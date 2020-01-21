const fs = require('fs')
const util = require('util')

const readdir = util.promisify(fs.readdir)
const appendFile = util.promisify(fs.appendFile)


const createCompaniesInsertStatements =  async () => {
  const companyFiles = await readdir('./companies')
  await appendFile('testDb.sql', `INSERT INTO companies (name, module_name,company_url, base_url, scrape_url, type) VALUES\n`)
  for (const file of companyFiles) {
    const companyMod = require(`../companies/${file}`)
    const moduleName = file.split('.js')[0]
    const hasBaseUrl = !!companyMod.baseUrl
    const baseUrl = hasBaseUrl ? `'${companyMod.baseUrl}'` : null
    const insertStatement = `('${companyMod.name}', '${moduleName}', '${companyMod.companyURL}', ${baseUrl}, '${companyMod.url}', '${companyMod.type}'), \n`
    await appendFile('testDb.sql', insertStatement)
  }
}

const createUsers_CompaniesInsertStatements = async () => {
  const connectorModules = require('../connectors')
  await appendFile('testDb.sql', `INSERT INTO users_companies (user_id, company_id) VALUES\n`)
  for (const connectorKey of Object.keys(connectorModules)) {
    const connector = connectorModules[connectorKey]
    for (const company of connector.companies) {
      const insertStatement = `(
  (SELECT user_id FROM users WHERE name ilike '${connector.name}'),
  (SELECT company_id FROM companies WHERE module_name = '${company}')
),\n`
      await appendFile('testDb.sql', insertStatement)
    }
  }
}

createUsers_CompaniesInsertStatements()
