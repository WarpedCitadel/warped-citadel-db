--liquibase  formatted sql

--changeset jnolte:20260522_create_profile_image
CREATE TABLE profile_image (
  id 					SERIAL 			NOT NULL PRIMARY KEY,
  app_user_profile_id	BIGINT			NOT NULL REFERENCES app_user_profile(id),
  img_uuid				UUID			NOT NULL DEFAULT uuidv7(),
  file_name 			VARCHAR(100)	NOT NULL,
  file_size 			VARCHAR(7)		NOT NULL,
  modified_dtm 			TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE profile_image IS 'Object metadata for profile image uploads.';
--rollback DROP TABLE IF EXISTS profile_image;


--changeset jnolte:20260522_create_profile_image_uk01 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY profile_image_uk01 ON profile_image(app_user_profile_id);


-- permissions
--changeset jnolte:20260522_grant_sec_perms_profile_image
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE profile_image TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE profile_image FROM wc_secure_role;


--changeset jnolte:20260522_grant_read_perms_on_profile_image
GRANT SELECT ON TABLE profile_image TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE profile_image FROM wc_read_only_role;