--liquibase formatted sql


--changeset jnolte:20260527_create_app_user
CREATE TABLE app_user (
 id 				SERIAL 			NOT NULL PRIMARY KEY,
 user_uuid			UUID			NOT NULL DEFAULT uuidv7(),
 username 			VARCHAR(50) 	NOT NULL,
 password_hash 		TEXT 			NOT NULL,
 email				VARCHAR(100) 	NOT NULL UNIQUE,
 role				SMALLINT 		NOT NUll REFERENCES role (id) DEFAULT 1,
 isactive			BOOLEAN			NOT NULL DEFAULT TRUE,
 isverified			BOOLEAN			NOT NULL DEFAULT FALSE,
 created_dtm 		TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC'),
 modified_dtm		TIMESTAMP(6)	NOT NUll DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);

COMMENT ON TABLE app_user IS 'Base details for users of the platform. More details in app_user_profile table.';
--rollback DROP TABLE IF EXISTS app_user;


--changeset jnolte:20260507_create_app_user_uk01 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY app_user_uk01 ON app_user(lower(username));

--changeset jnolte:20260516_create_app_user_uk02 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY app_user_uk02 ON app_user(user_uuid);


--triggers
--changeset jnolte:20260526_create_trg_app_user_session
CREATE TRIGGER app_user_session
BEFORE UPDATE ON app_user
	FOR EACH ROW EXECUTE FUNCTION fnc_table_row_audit_trg();
--rollback DROP TRIGGER IF EXISTS app_user_session ON app_user;


-- permissions
--changeset jnolte:20260506_grant_sec_perms_app_user
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_user TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_app_user
GRANT SELECT ON TABLE app_user TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user FROM wc_read_only_role;