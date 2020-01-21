const { Client } = require('pg')


const production = process.env.NODE_ENV === 'production'


let client = null
if (production) {
  client = new Client({
    connectionString: process.env.DATABASE_URL,
    ssl: true,
  })
} else {
  client = new Client({
    user: process.env.DB_USER,
    host: 'localhost',
    database: process.env.DB_DATABASE,
    port: process.env.DB_PORT,
    password: process.env.DB_PASS
  })
}
client.connect()

module.exports = client
