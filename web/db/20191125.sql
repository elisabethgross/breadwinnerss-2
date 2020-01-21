ALTER TABLE users ADD COLUMN hash TEXT;
ALTER TABLE users ADD COLUMN reset_password_token TEXT;
ALTER TABLE users ADD COLUMN reset_password_expires TIMESTAMP;
