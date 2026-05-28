--liquibase formatted sql


--changeset jnolte:20260527_create_app_user_audit
CREATE TABLE app_user_audit (
  id				SERIAL			NOT NULL PRIMARY KEY,
  app_user_id		BigInt			NOT NULL REFERENCES app_user (id),
  lastactive_dtm	TIMESTAMP(6)
);


COMMENT ON TABLE app_user IS 'Audit table for application users';
--rollback DROP TABLE IF EXISTS app_user_audit;


--triggers
--changeset jnolte:20260527_create_trg_app_user_session
CREATE TRIGGER app_user_session
BEFORE INSERT ON app_user_audit
	FOR EACH ROW EXECUTE FUNCTION fnc_table_row_audit_trg();
--rollback DROP TRIGGER IF EXISTS app_user_session ON app_user_audit;


-- permissions
--changeset jnolte:20260527_grant_sec_perms_app_user_audit
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_user TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user_audit FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_app_user_audit
GRANT SELECT ON TABLE app_user TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user_audit FROM wc_read_only_role;