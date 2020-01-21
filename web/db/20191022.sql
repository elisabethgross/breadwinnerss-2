CREATE TABLE single_job_postings (
  single_job_postings_id SERIAL PRIMARY KEY,
  job_title TEXT,
  url TEXT,
  location TEXT,
  user_id INT REFERENCES users(user_id)
);
