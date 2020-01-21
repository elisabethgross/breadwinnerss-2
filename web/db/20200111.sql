INSERT INTO users
  (users_name           , display_name      , first_name, email                      , url           , role_id) VALUES
  ('jordan'             , 'Jordan Siegel'   , 'Jordan'  , 'jordansiegel122@gmail.com', 'js_feed'     , 1);

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'jordansiegel122@gmail.com'),
  (SELECT company_id FROM companies WHERE module_name = 'yieldstreet'),
  null,
  null,
  null,
  null
);

INSERT INTO users
  (users_name    , display_name   , first_name, email                    , url           , role_id) VALUES
  ('matt'        , 'Matt Davis'   , 'Matt'    , 'matt.davis@alphahq.com' , 'firstlist'   , 1);

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE email ilike 'matt.davis@alphahq.com'),
  (SELECT company_id FROM companies WHERE module_name = 'alpha'),
  null,
  null,
  null,
  null
);
