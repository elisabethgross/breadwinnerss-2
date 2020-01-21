
INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('icims', 'icims', 'https://www.icims.com', 'https://careers.icims.com', 'https://careers.icims.com/jobs?page=1&location=New%20York,%20NY&woe=7&stretch=0&stretchUnit=MILES&limit=100', 'puppeteer');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'nisfrome@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'icims'),
  null,
  null,
  null,
  null
);
