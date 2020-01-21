// get list owners
module.exports.getConnectorList = async (client) => {
  const results = await client.query(`
    SELECT * FROM USERS
    WHERE role_id = 1
  `)
  return results.rows
}

module.exports.getConnectorCompanyModules = async (client) => {
  const results = await client.query(`
    SELECT * FROM users
    JOIN users_companies USING(user_id)
    JOIN companies USING(company_id)
    WHERE users.role_id = 1
  `)
  return results.rows
}

module.exports.getConnectorCompanyModulesSingle = async (client, connector_url) => {
  const results = await client.query(`
    SELECT * FROM users
    JOIN users_companies USING(user_id)
    JOIN companies USING(company_id)
    WHERE users.role_id = 1
    AND users.url = $1::TEXT
  `, [connector_url])
  return results.rows
}

module.exports.addSingleJobPosting = async (client, companyName, jobTitle, url, location, connector_url) => {
  const results = await client.query(`
    INSERT INTO single_job_postings
    (single_job_postings_company_name, job_title, url, location, user_id)
    VALUES
    ($1::TEXT, $2::TEXT, $3::TEXT, $4::TEXT, (
      SELECT user_id
      FROM users
      WHERE url = $5::TEXT
    ))
    RETURNING *
  `, [companyName, jobTitle, url, location, connector_url])
  return results.rows
}

module.exports.getSingleJobPostings = async (client, url) => {
  const results = await client.query(`
    SELECT *
    FROM single_job_postings
    WHERE user_id = (
      SELECT user_id
      FROM users
      WHERE url = $1::TEXT
    )
  `, [url])
  return results.rows
}

module.exports.deleteSingleJobPosting = async (client, single_job_postings_id) => {
  const results = await client.query(`
    DELETE FROM single_job_postings
    WHERE single_job_postings_id = $1::INT
  `, [single_job_postings_id])
  return results.rows
}
