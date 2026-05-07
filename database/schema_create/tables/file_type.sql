--liquibase formatted sql

--changeset jnolte:20260612_create_file_type
CREATE TABLE file_type (
  id 				SERIAL NOT NULL PRIMARY KEY,
  file_type_name 	BIGINT NOT NULL
);

COMMENT ON TABLE file_type IS 'static data for accepted file types';
--rollback DROP TABLE IF EXISTS file_type;


-- permissions
--changeset jnolte:20260506_grant_sec_perms_file_type
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE file_type TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_file_type
GRANT SELECT ON TABLE file_type TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user FROM wc_read_only_role;
