-- ===========================================
-- create app_user_profile
-- ===========================================
CREATE TABLE app_user_profile (
  id SERIAL 		NOT NULL PRIMARY KEY,
  app_user_id 		BIGINT NOT NULL REFERENCES wc01.app_user (id),
  app_user_file_id 	BIGINT NOT NULL REFERENCES wc01.app_user_file (id)
);