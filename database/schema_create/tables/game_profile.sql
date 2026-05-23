--liquibase formatted sql

--changeset jnolte:20260523_create_game_profile
CREATE TABLE game_profile (
	id				SERIAL			NOT NULL PRIMARY KEY,
	app_file_id		BIGINT			NOT NULL REFERENCES app_file (id),
	title			VARCHAR(100)	NOT NULL,
	description		TEXT			CONSTRAINT game_desc_length CHECK (char_length(description) <= 5000),
	genre_id		SMALLINT		NOT NULL REFERENCES genre (id),
	created_dtm		TIMESTAMP(6)	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC'),
	modified_dtm	TIMESTAMP(6)	DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE game_profile IS 'Detailed information for uploaded games';
--rollback DROP TABLE IF EXISTS game_profile;


-- permissions
--changeset jnolte:20260521_grant_sec_perms_game_profile
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE game_profile TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE game_profile FROM wc_secure_role;


--changeset jnolte:20260521_grant_read_perms_on_game_profile
GRANT SELECT ON TABLE game_profile TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_profile FROM wc_read_only_role;