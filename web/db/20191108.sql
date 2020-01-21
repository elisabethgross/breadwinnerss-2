UPDATE users SET display_name = 'Hannah', first_name = 'Hannah', url = 'hannah', role_id = 1 WHERE email = 'hbertiger@gmail.com';

UPDATE USERS SET image_url = 'https://media.licdn.com/dms/image/C4D03AQHYPhfqOtzb6A/profile-displayphoto-shrink_200_200/0?e=1581552000&v=beta&t=XYM1pJ9srOIb538xTXh2Np1kD2fmEzkj2Qd6i9vTzJM' WHERE url = 'hannah';

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'hbertiger@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'walmart'),
  null,
  null,
  null,
  null
);

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'hbertiger@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'alpha'),
  null,
  null,
  null,
  null
);

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'hbertiger@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'peloton'),
  null,
  null,
  '{"people", "product"}',
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Exubrancy', 'exubrancy', 'http://www.exubrancy.com', 'http://www.exubrancy.com/careers', 'http://www.exubrancy.com/careers', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'hbertiger@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'exubrancy'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Talkspace', 'talkspace', 'https://www.talkspace.com', 'https://apply.workable.com/talkspace/j', 'https://apply.workable.com/talkspace', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'hbertiger@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'talkspace'),
  null,
  null,
  '{"Product"}',
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Blink Health', 'blinkhealth', 'https://www.blinkhealth.com', 'https://boards.greenhouse.io', 'https://boards.greenhouse.io/blinkhealth', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'hbertiger@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'blinkhealth'),
  '{"ux"}',
  null,
  '{"product"}',
  null
);
