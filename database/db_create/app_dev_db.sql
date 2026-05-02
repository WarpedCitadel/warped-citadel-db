-- ********* YOU NEED TO BE RUNNING AS THE POSTGRES *********
-- ********* SUPER USER TO EXECUTE THIS SQL SCRIPT  *********

-- ===========================================
-- postgres: Drop Public Schema from postgres Database
-- ===========================================

DROP SCHEMA IF EXISTS public CASCADE;

-- ===========================================
-- If app_dev_db exists drop the database
-- ===========================================

DROP DATABASE IF EXISTS app_dev_db;

-- ===========================================
-- create new database app_dev_db
-- ===========================================

CREATE DATABASE app_dev_db;

-- ===========================================
-- Connect to the new database
-- ===========================================

\c app_dev_db

-- ===========================================
-- drop schema public
-- ===========================================

DROP SCHEMA IF EXISTS public CASCADE;

-- ===========================================
-- create schema wc01
-- ===========================================

CREATE SCHEMA wc01; 

-- ===========================================
-- create app_user
-- ===========================================

CREATE TABLE wc01.app_user (
 id 			SERIAL NOT NULL PRIMARY KEY,
 username 		VARCHAR(50) NOT NULL UNIQUE,
 password_hash 	VARCHAR(255) NOT NULL,
 email			VARCHAR(225) NOT NULL UNIQUE,
 --role			VARCHAR(255) NOT NUll,
 created_dtm 	TIMESTAMP(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);

-- ===========================================
-- create file_type
-- ===========================================

CREATE TABLE wc01.file_type (
  id 				SERIAL NOT NULL PRIMARY KEY,
  file_type_name 	BIGINT NOT NULL
);

-- ===========================================
-- create status_type
-- ===========================================

CREATE TABLE wc01.status_type (
  id 				SERIAL NOT NULL PRIMARY KEY,
  status_type_name 	BIGINT NOT NULL
);

-- ===========================================
-- create app_file
-- ===========================================

CREATE TABLE wc01.app_file (
  id 				BIGINT NOT NULL PRIMARY KEY,
  app_user_id 		BIGINT NOT NULL REFERENCES wc01.app_user (id),
  file_name 		VARCHAR(255) NOT NULL,
  file_path 		VARCHAR(255) NOT NULL,
  file_version 		VARCHAR(255) NOT NULL,
  file_size 		BIGINT NOT NULL,
  file_type_id 		BIGINT NOT NULL REFERENCES wc01.file_type (id),
  status_type_id 	BIGINT NOT NULL REFERENCES wc01.status_type (id),
  created_dtm 		TIMESTAMP(6) NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);

-- ===========================================
-- create app_user_profile
-- ===========================================

CREATE TABLE wc01.app_user_profile (
  id SERIAL 		NOT NULL PRIMARY KEY,
  app_user_id 		BIGINT NOT NULL REFERENCES wc01.app_user (id),
  app_user_file_id 	BIGINT NOT NULL REFERENCES wc01.app_user_file (id)
);

