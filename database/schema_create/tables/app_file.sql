-- ===========================================
-- create app_file
-- ===========================================
CREATE TABLE app_file (
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