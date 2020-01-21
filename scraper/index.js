// Heavily inspired by: https://swizec.com/blog/serverless-chrome-on-aws-lambda-the-guide-works-in-2019-beyond/swizec/9024
// LIZ TODO: Clean this up into well named files / modular goodness
// LIZ TODO: Fix permissions on bucket (currently wide open, was having issues. I hate AWS permissioning.)
// LIZ NOTE: You MIGHT have to go to node_modules/@serverless-chrome/dist/ [bundle.cjs.js, bundle.es.js] and remove the -v99 flag from logging flags

const aws = require('aws-sdk')
const axios = require('axios')
const cheerio = require('cheerio')
const _ = require('lodash')
const s3 = new aws.S3()
require('dotenv').config()

// hit company's career page
async function hitCareersPage (companyModule, browser) {
  let data = null
  switch (companyModule.type) {
    case 'cheerio': {
      if (_.isArray(companyModule.url)) {
        data = await Promise.all(companyModule.url.map(async url => {
          let res = null
          try {
            res = await axios.get(url)
            return res.data
          } catch (e) {
            console.log('error', e)
          }
          return res
        }))
        // filters out undefined values
        data = data.filter(html => html)
      } else {
        try {
          let res = await axios.get(companyModule.url)
          data = res.data
        } catch (e) {
          console.log('error', e)
        }
      }
      break
    }
    case 'puppeteer': {
      if (_.isArray(companyModule.url)) {
        data = await Promise.all(companyModule.url.map(async url => {
          let page = await browser.newPage()
          try {
            await page.goto(url)
            await page.waitForSelector(companyModule.targetElSelector)
            return await page.content()
          } catch (e) {
            console.log('url', url)
            console.log('error', e)
          }
        }))
        // filters out undefined values
        data = data.filter(html => html)
      } else {
        let page = await browser.newPage()
        try {
          await page.goto(companyModule.url)
          await page.waitForSelector(companyModule.targetElSelector)
          data = await page.content()
        } catch (e) {
          console.log('error', e)
        }
      }
      break
    }
  }
  return data
}

// hit a company's careers page, cheerio load the response, call the company's findJob method
async function scrape (companyModule, browser) {
  const data = await hitCareersPage(companyModule, browser)
  let jobs = []
  if (!data) {
    jobs = []
  }
  else if (_.isArray(data)) {
    const cheerios = data.map(html => cheerio.load(html))
    const jobsArr = await Promise.all(cheerios.map(async $ => {
      return await companyModule.findJob($)
    }))
    jobs = _.flatten(jobsArr)
  } else {
    const $ = cheerio.load(data)
    jobs = await companyModule.findJob($)
  }
  return {
    companyName: companyModule.name,
    companyURL: companyModule.companyURL,
    jobs
  }
}

// Crown jewel function
function calculateProgress (incrementor, totalCompanies) {
  const percentDone = Math.floor((incrementor / totalCompanies) * 100)
  let equalSigns = _.times(Math.ceil(percentDone / 2), () => { return '=' }).join('')
  let emptySpaces = _.times((100 - percentDone) / 2, () => { return ' '}).join('')

  const percentText = `${percentDone}%`
  if (percentText.length === 2) {
    // single digit percentages
    emptySpaces = emptySpaces.slice(2)
  } else if (percentDone > 92 && percentDone < 97) {
    emptySpaces = ' '
    equalSigns = equalSigns.slice(2)
  } else if (percentDone > 96 && percentDone < 100) {
    emptySpaces = ' '
    equalSigns = equalSigns.slice(3)
  } else if (percentDone === 100) {
    emptySpaces = ''
    equalSigns = equalSigns.slice(4)
  } else {
    emptySpaces = emptySpaces.slice(3)
  }

  return `[${equalSigns}${emptySpaces}${percentText}]`
}

// loop over company modules, scrape em
async function processCompanies (browser, companies) {

  const processedCompanies = []
  let incrementor = 0
  const totalCompanies = companies.length
  for (const connectorCompany of companies) {
    incrementor++
    const { target_jobs, bad_jobs, target_depts, bad_depts, module_name, scrape_url, base_url, companies_name, company_url, type } = connectorCompany
    console.log(`Scraping ${module_name}...`)
    console.log(calculateProgress(incrementor, totalCompanies))
    const companyModule = require(`./companies/${module_name}.js`)
    const connectorCompanyModule = new companyModule(target_jobs, bad_jobs, target_depts, bad_depts, scrape_url, base_url, companies_name, company_url, type)
    const result = await scrape(connectorCompanyModule, browser)
    processedCompanies.push(result)
  }
  return processedCompanies
}

async function getConnectorCompanySingle (moduleName, connectorUrl) {
  const connectorCompanies = await axios.get(`${process.env.CONNECTORS_URL}/connector-modules/${connectorUrl}`)
  return _.find(connectorCompanies.data, (connectorCompany) => {
    return connectorCompany.module_name === moduleName
  })
}

async function getConnectorCompanies () {
  return await axios.get(`${process.env.CONNECTORS_URL}/connector-modules`)
}

exports.go = async (req, res) => {
  // setup
  const puppeteer = require('puppeteer')
  const browser = await puppeteer.launch({args: ['--no-sandbox']})

  // used for testing, you can specify a company and connector to scrape
  // i.e. npm run scrape to start cloud functions local server
  // curl -X POST http://localhost:8080 -H "Content-Type:application/json"  -d '{"connector":"nis", "module":"alpha"}'
  const testingScraper = req.body && req.body.connector && req.body.module

  const forS3 = {}
  console.log('About to start the scraping...')
  if (testingScraper) {
    const moduleName = req.body.module
    const connectorUrl = req.body.connector
    const companyModule = require(`./companies/${moduleName}.js`)
    const { target_jobs, bad_jobs, target_depts, bad_depts, scrape_url, base_url, companies_name, company_url, type } = await getConnectorCompanySingle(moduleName, connectorUrl)
    const connectorCompanyModule = new companyModule(target_jobs, bad_jobs, target_depts, bad_depts, scrape_url, base_url, companies_name, company_url, type)
    const processed = await scrape(connectorCompanyModule, browser)
    console.log('processed', processed)
  } else {
    const connectorCompanies = await getConnectorCompanies()
    const connectorCompaniesGroupedByConnector = _.groupBy(connectorCompanies.data, 'user_id')

    for (const user_id of Object.keys(connectorCompaniesGroupedByConnector)) {
      const companies = connectorCompaniesGroupedByConnector[user_id]
      // pull this off the first one, each company has this info
      const { display_name, first_name, email, url } = companies[0]
      const processed = await processCompanies(browser, companies)
      console.log(`Received processed jobs: ${processed}`)
      forS3[url] = {
        connector: display_name,
        firstName: first_name,
        email: email,
        companies: processed
      }
    }
  }

  // cleanup
  await browser.close()


  if (!testingScraper) {
    await s3.putObject({
      Bucket: 'breadwinnerss',
      Key: 'today.json',
      ContentType: 'application/json',
      Body: Buffer.from(JSON.stringify(forS3)),
      ACL: 'private'
    }).promise()
  }

  res.status(200).send(JSON.stringify(forS3))
}
