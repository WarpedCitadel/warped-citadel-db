--liquibase formatted sql

--changeset jnolte:20260612_create_app_user_profile
CREATE TABLE app_user_profile (
  id 				SERIAL 	NOT NULL PRIMARY KEY,
  app_user_id 		BIGINT 	NOT NULL REFERENCES app_user (id),
  app_user_file_id	BIGINT	NOT NULL REFERENCES app_file (id)
);

COMMENT ON TABLE app_user_profile IS 'Detailed information for a users profile on the platform.';
--rollback DROP TABLE IF EXISTS app_user_profile;


-- permissions
--changeset jnolte:20260506_grant_sec_perms_app_user_profile
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_user_profile TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_app_user_profile
GRANT SELECT ON TABLE app_user_profile TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user FROM wc_read_only_role;