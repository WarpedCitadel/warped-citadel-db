--liquibase formatted sql

--changeset jnolte:20260612_create_app_user
CREATE TABLE app_user (
 id 			SERIAL 			NOT NULL PRIMARY KEY,
 --auth_uuid	UUID			NOT NULL,
 username 		VARCHAR(50) 	NOT NULL UNIQUE,
 password_hash 	TEXT 			NOT NULL,
 email			VARCHAR(100) 	NOT NULL UNIQUE,
 --role			VARCHAR(50) NOT NUll,
 created_dtm 	TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);
--rollback DROP TABLE IF EXISTS app_user;


-- permissions
--changeset jnolte:20260612_grant_sec_perms_app_user
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_user TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user FROM wc_secure_role;


--changeset jnolte:20260612_grant_read_perms_on_app_user
GRANT SELECT ON TABLE app_user TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user FROM wc_read_only_role;