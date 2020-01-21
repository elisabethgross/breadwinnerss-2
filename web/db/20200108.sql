
INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('sevenrooms', 'sevenrooms', 'https://sevenrooms.com', '', 'https://sevenrooms.com/en/careers', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'nisfrome@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'sevenrooms'),
  null,
  null,
  null,
  null
);
