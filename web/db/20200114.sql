INSERT INTO users
  (users_name, display_name, first_name, email, url, image_url, role_id) VALUES
  ('gretchen', 'Gretchen', 'Gretchen', 'gretchen@alphahq.com', 'gretchen', 'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 1);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Qualtrics', 'qualtrics', 'https://www.qualtrics.com', '', 'https://www.qualtrics.com/careers/?department=Sales#explore,https://www.qualtrics.com/careers/?department=Marketing#explore', 'puppeteer');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gretchen'),
  (SELECT company_id FROM companies WHERE module_name = 'qualtrics'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Awardco', 'awardco', 'https://www.award.co', '', 'https://www.award.co/careers', 'puppeteer');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gretchen'),
  (SELECT company_id FROM companies WHERE module_name = 'awardco'),
  null,
  null,
  '{"marketing", "sales"}',
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('National Grid', 'nationalgrid', 'https://www.nationalgridus.com/', '', 'https://careers.nationalgridus.com', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gretchen'),
  (SELECT company_id FROM companies WHERE module_name = 'nationalgrid'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Morgan Stanley', 'morganstanley', 'https://www.morganstanley.com/', '', 'https://ms.taleo.net/careersection/2/jobsearch.ftl?lang=en', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gretchen'),
  (SELECT company_id FROM companies WHERE module_name = 'morganstanley'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Humana', 'humana', 'https://www.humana.com', '', 'https://humana.wd5.myworkdayjobs.com/Humana_External_Career_Site', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gretchen'),
  (SELECT company_id FROM companies WHERE module_name = 'humana'),
  null,
  null,
  null,
  null
);
