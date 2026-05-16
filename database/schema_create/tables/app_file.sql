--liquibase formatted sql

--changeset jnolte:20260612_create_app_file
CREATE TABLE app_file (
  id 				SERIAL 			NOT NULL PRIMARY KEY,
  uuid				UUID			NOT NULL DEFAULT uuidv7(),
  app_user_id		BigInt			NOT NULL REFERENCES app_user (id),
  file_name 		VARCHAR(100)	NOT NULL,
  file_version 		VARCHAR(20)		NOT NULL,
  file_size 		TEXT			NOT NULL,
  file_type 		VARCHAR(5) 		NOT NULL,
  status_type_id 	SMALLINT 		NOT NULL REFERENCES status_type (id),
  created_dtm 		TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC'),
  modified_dtm		TIMESTAMP(6)	DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);

COMMENT ON TABLE app_file IS 'Object metadata for all file uploads for the platform.';
--rollback DROP TABLE IF EXISTS app_file;


-- permissions
--changeset jnolte:20260506_grant_sec_perms_app_file
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_file TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_file FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_app_file
GRANT SELECT ON TABLE app_file TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_file FROM wc_read_only_role;