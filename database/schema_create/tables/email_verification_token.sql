--liquibase formatted sql


--changeset jnolte:20260610_email_verification_token
CREATE TABLE email_verification_token (
 id 				SERIAL 			NOT NULL PRIMARY KEY,
 app_user_id		SERIAL			NOT NULL REFERENCES app_user (id),
 token 				TEXT 			NOT NULL,
 passcode			varchar(6)		NOT NULL,
 isused				BOOLEAN			NOT NULL DEFAULT false,
 created_dtm 		TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC'),
 expires_dtm		TIMESTAMP(6)	NOT NUll DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE email_verification_token IS 'Token table for user email confirmation.';
--rollback DROP TABLE IF EXISTS email_verification_token;


--changeset jnolte:20260610_email_verification_token_uk01 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY email_verification_token_uk01 ON email_verification_token(app_user_id);


-- permissions
--changeset jnolte:20260610_grant_sec_perms_email_verification_token
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE email_verification_token TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE email_verification_token FROM wc_secure_role;


--changeset jnolte:20260610_grant_read_perms_on_email_verification_token
GRANT SELECT ON TABLE email_verification_token TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE email_verification_token FROM wc_read_only_role;