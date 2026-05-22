--liquibase  formatted sql

--changeset jnolte:20260521_create_app_file_image
CREATE TABLE app_file_image (
  id 				SERIAL 			NOT NULL PRIMARY KEY,
  uuid				UUID			NOT NULL DEFAULT uuidv7(),
  app_user_id		BigInt			NOT NULL REFERENCES app_user (id),
  file_name 		VARCHAR(100)	NOT NULL,
  file_size 		VARCHAR(7)		NOT NULL,
  created_dtm 		TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE app_file_image IS 'Object metadata for image file uploads for the platform.';
--rollback DROP TABLE IF EXISTS app_file_image;


--changeset jnolte:20260520_create_app_file_image_uk01 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY app_file_image_uk01 ON app_file_image(uuid);


-- permissions
--changeset jnolte:20260520_grant_sec_perms_app_file_image
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_file_image TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_file_image FROM wc_secure_role;


--changeset jnolte:20260520_grant_read_perms_on_app_file_image
GRANT SELECT ON TABLE app_file_image TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_file_image FROM wc_read_only_role;