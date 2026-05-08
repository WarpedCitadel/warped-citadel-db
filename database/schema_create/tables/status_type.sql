--liquibase formatted sql

--changeset jnolte:20260612_create_status_type
CREATE TABLE status_type (
  id 				SERIAL 		NOT NULL PRIMARY KEY,
  status_type_name 	VARCHAR(8) 	NOT NULL,
  CONSTRAINT cap_id CHECK (id <= 4)
);

COMMENT ON TABLE status_type IS 'static values for a app_file object vetting and approval status';
--rollback DROP TABLE IF EXISTS status_type;


-- create status types
INSERT INTO status_type (status_type_name) VALUES ('scanning'), ('review'), ('active'), ('deleted');


-- permissions
--changeset jnolte:20260506_grant_sec_perms_status_type
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE status_type TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_status_type
GRANT SELECT ON TABLE status_type TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user FROM wc_read_only_role;