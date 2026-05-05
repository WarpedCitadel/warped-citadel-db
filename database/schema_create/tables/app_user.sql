-- ===========================================
-- create app_user
-- ===========================================
CREATE TABLE app_user (
 id 			SERIAL NOT NULL PRIMARY KEY,
 username 		VARCHAR(50) NOT NULL UNIQUE,
 password_hash 	TEXT NOT NULL,
 email			VARCHAR(100) NOT NULL UNIQUE,
 --role			VARCHAR(50) NOT NUll,
 created_dtm 	TIMESTAMP(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);