INSERT INTO users
  (users_name, display_name, first_name, email, url, image_url, role_id) VALUES
  ('tom', 'Tom', 'Tom', 'tom@alphahq.com', 'tomburg', 'https://media-exp2.licdn.com/dms/image/C4E03AQF8eMa88ZbL5Q/profile-displayphoto-shrink_200_200/0?e=1584576000&v=beta&t=h6lSsnkaHj2WqAzn8NQXecyIp4f-wid_xJcxYwz3NVw', 1);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Centro', 'centro', 'https://www.centro.net', '', 'https://jobs.lever.co/centro?team=Sales,https://jobs.lever.co/centro?team=Marketing', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'tom'),
  (SELECT company_id FROM companies WHERE module_name = 'centro'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Integral Ad Science', 'integraladscience', 'https://integralads.com', '', 'https://boards.greenhouse.io/embed/job_board?for=integraladscience&b=https%3A%2F%2Fintegralads.com%2Fcareers%2Fjob-openings%2F', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'tom'),
  (SELECT company_id FROM companies WHERE module_name = 'integraladscience'),
  null,
  null,
  '{"marketing", "sales"}',
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('MediaMath', 'mediamath', 'https://www.mediamath.com', 'https://www.mediamath.com', 'https://www.mediamath.com/careers/open-positions', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'tom'),
  (SELECT company_id FROM companies WHERE module_name = 'mediamath'),
  null,
  null,
  '{"marketing", "sales"}',
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Hired Guns', 'hiredguns', 'https://thehiredguns.com', '', 'https://thehiredguns.com/gig', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'tom'),
  (SELECT company_id FROM companies WHERE module_name = 'hiredguns'),
  null,
  null,
  null,
  null
);

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'tom'),
  (SELECT company_id FROM companies WHERE module_name = 'alpha'),
  null,
  null,
  null,
  null
);
