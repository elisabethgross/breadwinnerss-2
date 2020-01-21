require('dotenv').config()
const express = require('express')
const cors = require('cors')
const AWS = require('aws-sdk')
const _ = require('lodash')
const bodyParser = require('body-parser')
const morgan = require('morgan')
const sgMail = require('@sendgrid/mail')
const Handlebars = require('handlebars')
const session = require('express-session')
const passport = require('passport')
const LocalStrategy = require('passport-local').Strategy
const bcrypt = require('bcryptjs')
const path = require('path')
const fs = require('fs')
const { promisify } = require('util')
const readFileAsync = promisify(fs.readFile)

const app = express()
const dbMethods = require('./db')
const client = require('./dbConnection')

const production = process.env.NODE_ENV === 'production'

const REQUIRED_SECRETS = ['AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY']
if (production) {
  REQUIRED_SECRETS.push('DATABASE_URL')
} else {
  REQUIRED_SECRETS.push('DB_USER', 'DB_HOST', 'DB_DATABASE', 'DB_PORT', 'DB_PASS')
}

REQUIRED_SECRETS.forEach(secret => {
  if (!process.env[secret]) {
    throw new Error(`Missing required env variable: ${secret}`)
  }
})

const s3 = new AWS.S3()

// Redirect to use https
if (production) {
  app.use((req, res, next) => {
    if (req.header('x-forwarded-proto') !== 'https') {
      res.redirect(`https://${req.header('host')}${req.url}`)
    } else {
      next()
    }
  })
}

app.use(morgan('tiny'))

// Initialize and configure Express sessions
app.use(session({
  secret: 'ha8hWp,yoZF',  // random characters for secret
  cookie: { maxAge: 60000 }, // cookie expires after some time
  saveUninitialized: true,
  resave: true
}))
app.use(cors( {origin: 'http://localhost:8080', credentials: true}))
app.use(express.static('dist'))
app.use(bodyParser.json())

/************************
*    PASSPORT CONFIG    *
*************************/
app.use(passport.initialize())
app.use(passport.session())

passport.use(new LocalStrategy({
  passReqToCallback: true // Passes req to the cb function, so we can put messages there if needed
}, async (req, username, password, done) => {
  try {
    const results = await client.query(`SELECT * FROM users WHERE email = $1::TEXT`, [username])
    const user = results.rows[0]
    if (!user) {
      console.log('user not found')
      return done(null, false)
    }
    const userHash = user.hash
    bcrypt.compare(password, userHash, (err, matches) => {
      if (err) {
        return done(err)
      }
      if (!matches) {
        console.log('incorrect username and/or password')
        return done(null, false)
      }
      console.log('found user')
      return done(null, user)
    })

  } catch (e) {
    console.log('e', e)
    return done(e)
  }
}))

// Tells passport what information to include in the session
// This will be run after authentication
// Just need ID for lookup later
passport.serializeUser(function(user, done) {
  done(null, user.user_id)
})

// Tells passport how to get user from information in session
// This will run on every request for which session data exists in a cookie.
passport.deserializeUser(async (id, done) => {
  const q = `SELECT * FROM users WHERE user_id = $1::INT`
  try {
    const { rows } = await client.query(q, [id])
    done(null, rows[0]) // rows[0] will be stored in req.user for use in later middleware
  } catch(e) {
    console.log('e', e)
    done(e)
  }
})

app.use(require('./routes/auth'))

function isAuthenticated(req, res, next) {
  if (req.isAuthenticated()) {
    return next()
  }
  res.redirect('/')
}

app.get('/connector-list', async (req, res) => {
  const connectors = await dbMethods.getConnectorList(client)
  const mapped = _.map(connectors, (connector) => {
    return {
      display_name: connector.display_name,
      url: connector.url
    }
  })
  res.json(mapped)
})

// sometimes scrape_url is a comma separated string list *sigh*
// pass the string if its a single, pass array of strings if multiple
// stupid
function connectorModuleMapper (modules) {
  const modulesMapped = modules.map(module => {
    const scrapeUrlArr = module.scrape_url.split(',')
    module.scrape_url = scrapeUrlArr.length === 1 ? scrapeUrlArr[0] : scrapeUrlArr
    return module
  })
  return modulesMapped
}

app.get('/connector-modules', async (req, res) => {
  const connectorCompanyModules = await dbMethods.getConnectorCompanyModules(client)
  const modulesMapped = connectorModuleMapper(connectorCompanyModules)
  res.json(modulesMapped)
})

app.get('/connector-modules/:connector_url', async (req, res) => {
  const connectorCompanyModules = await dbMethods.getConnectorCompanyModulesSingle(client, req.params.connector_url)
  const modulesMapped = connectorModuleMapper(connectorCompanyModules)
  res.json(modulesMapped)
})

app.post('/connector-modules/:connector_url', isAuthenticated, async (req, res) => {
  const { companyName, jobTitle, url, location } = req.body
  const results = await dbMethods.addSingleJobPosting(client, companyName, jobTitle, url, location, req.params.connector_url)
  res.json(results)
})

app.delete('/connector-modules/:connector_url', isAuthenticated, async (req, res) => {
  const { single_job_postings_id } = req.body
  await dbMethods.deleteSingleJobPosting(client, single_job_postings_id)
  res.sendStatus(200)
})

app.get('/connector/:connector', async (req, res) => {
  // save email and name in users table
  const { email, name } = req.query
  const connector = req.params.connector.toLowerCase()
  const GENERIC_ERROR = 'Error fetching connector information, please try again later.'
  let connectorInfo = false
  try {
    connectorInfo = await client.query(`
      SELECT * FROM users
      WHERE url = $1::TEXT AND role_id = 1
      `, [connector]
    )
    if (!connectorInfo.rows.length) {
      res.status(404).send('Unknown connector.')
      return
    }
  } catch (e) {
    res.status(500).send(GENERIC_ERROR)
    return
  }
  if (email && name) {
    try {
      await client.query(`
        INSERT INTO users
        (users_name, email, role_id)
        VALUES
        (
          $1::TEXT,
          $2::TEXT,
          (SELECT role_id FROM roles WHERE name = 'job_seeker')
        )
        ON CONFLICT (email) DO NOTHING;
      `, [name.toLowerCase(), email.toLowerCase()])
    } catch (e) {
      console.error(e)
      res.status(500).send(GENERIC_ERROR)
    }
  }
  // get jobs data from s3
  const [s3Data, singleJobPostings] = await Promise.all(
    [(s3.getObject({
      Bucket: 'breadwinnerss',
      Key: 'today.json'
    }).promise()),
    dbMethods.getSingleJobPostings(client, connector) // get single job postings data
  ]).catch(reason => {
    console.log('Error getting connector data', reason)
  })

  const groupedByCompany = _.groupBy(singleJobPostings, (jobPosting) => jobPosting.single_job_postings_company_name)

  const singleJobPostingsFormatted = []
  _.forEach(groupedByCompany, (companyJobs, companyName) => {
    singleJobPostingsFormatted.push({
      companyName,
      jobs: companyJobs.reduce((agg, jobPosting) => {
        agg.push({
          single_job_postings_id: jobPosting.single_job_postings_id,
          jobTitle: jobPosting.job_title,
          location: jobPosting.location,
          url: jobPosting.url,
          type: 'single'
        })
        return agg
      }, [])
    })
  })

  const connectorsToJobs = JSON.parse(s3Data.Body.toString())
  const connectorJobs = connectorsToJobs[connector] || {}
  const connectorJobsCompanies = connectorJobs.companies || []
  connectorJobs.companies = [...connectorJobsCompanies, ...singleJobPostingsFormatted]
  connectorJobs.connectorImage = connectorInfo && connectorInfo.rows[0] && connectorInfo.rows[0].image_url
  return res.json(connectorJobs)
})

app.post('/make-intros', async (req, res) => {
  const emailHtml = await readFileAsync('./request-intro-email.html', 'utf-8')
  const template = Handlebars.compile(emailHtml)
  const html = template(req.body)

  sgMail.setApiKey(process.env.SENDGRID_API_KEY)
  const msg = {
    to: req.body.connectorEmail,
    from: 'hi@breadwinnerss.com',
    subject: `${req.body.userName} (${req.body.userEmail}) requested intros from your breadwinnerss feed`,
    html: html
  }
  sgMail.send(msg)
  res.sendStatus(200)
})

app.use((req, res) => {
  return res.sendFile(path.join(__dirname, 'dist', 'index.html'))
})

app.listen(process.env.PORT || 3000, () => {
	console.log(`Breadwinners is listening on port ${process.env.PORT || 3000}`)
})
