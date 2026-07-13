--liquibase formatted sql

--changeset jnolte:20260623_create_app_user_profile
CREATE TABLE app_user_profile (
  id 				SERIAL 			NOT NULL PRIMARY KEY,
  app_user_id 		BIGINT 			NOT NULL REFERENCES app_user (id),
  display_name		Varchar(50),
  user_bio			TEXT 			CONSTRAINT user_bio_length CHECK (char_length(user_bio) <= 5000),
  modified_dtm		TIMESTAMP(6)	NOT NUll DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE app_user_profile IS 'Detailed profile information for app user.';
--rollback DROP TABLE IF EXISTS app_user_profile;


--changeset jnolte:20260522_create_app_user_profile_uk02 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY app_user_profile_uk02 ON app_user_profile(id);


--changeset jnolte:20260516_create_app_user_profile_uk01 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY app_user_profile_uk01 ON app_user_profile(app_user_id);


-- sequence
--changeset jnolte:20260627_restart_app_user_profile_id_seq
ALTER SEQUENCE app_user_profile_id_seq
 INCREMENT BY 1
 START WITH 1
 RESTART WITH 1
 NO MAXVALUE
 NO MINVALUE
 CACHE 1
 NO CYCLE;
--xrollback DROP SEQUENCE IF EXISTS app_user_profile_id_seq;
--rollback not required


--triggers
--changeset jnolte:20260526_create_trg_app_user_profile_session
CREATE TRIGGER app_user_profile_session
BEFORE INSERT OR UPDATE ON app_user_profile
	FOR EACH ROW EXECUTE FUNCTION fnc_table_row_audit_trg();
--rollback DROP TRIGGER IF EXISTS app_user_profile_session ON app_user_profile;


--changeset jnolte:20260713_create_trg_insert_default_img
CREATE TRIGGER insert_default_img
AFTER INSERT ON app_user_profile
	FOR EACH ROW EXECUTE FUNCTION fnc_table_row_profile_image_trg();
--rollback DROP TRIGGER IF EXISTS insert_default_img ON app_user_profile;


-- permissions
--changeset jnolte:20260506_grant_sec_perms_app_user_profile
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE app_user_profile TO wc_secure_role;
GRANT USAGE ON SEQUENCE app_user_profile_id_seq TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE app_user FROM wc_secure_role;
--rollback REVOKE USAGE ON SEQUENCE app_user_profile_id_seq FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_app_user_profile
GRANT SELECT ON TABLE app_user_profile TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE app_user FROM wc_read_only_role;