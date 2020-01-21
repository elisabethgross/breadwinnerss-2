-- remove voray
DELETE FROM users_companies WHERE users_companies_id = 11;

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Elysium Health', 'elysiumhealth', 'https://www.elysiumhealth.com/en-us', '', 'https://hire.withgoogle.com/public/jobs/elysiumhealthcom?background=rgba(0%2C%200%2C%200%2C%200)&no_padding=1', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'nisfrome@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'elysiumhealth'),
  null,
  null,
  '{"marketing", "product"}',
  null
);
