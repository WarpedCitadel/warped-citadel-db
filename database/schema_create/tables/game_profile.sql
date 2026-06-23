--liquibase formatted sql

--changeset jnolte:20260523_create_game_profile
CREATE TABLE game_profile (
	id					SERIAL			NOT NULL PRIMARY KEY,
	app_user_id			BIGINT			NOT NULL REFERENCES app_user (id),
	game_profile_uuid	UUID			NOT NULL DEFAULT uuidv7(),
	title				VARCHAR(100)	NOT NULL,
	short_desc			TEXT			CONSTRAINT game_short_desc_length CHECK (char_length(short_desc) <= 200),
	description			TEXT			CONSTRAINT game_desc_length CHECK (char_length(description) <= 2000),
	game_genre_id		SMALLINT		NOT NULL REFERENCES game_genre (id),
	game_type_id		SMALLINT		NOT NULL REFERENCES game_type (id),
	created_dtm			TIMESTAMP(6)	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC'),
	modified_dtm		TIMESTAMP(6)	DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE game_profile IS 'Detailed information for uploaded games';
--rollback DROP TABLE IF EXISTS game_profile;


--triggers
--changeset jnolte:20260623_create_trg_game_profile_delete
CREATE TRIGGER game_profile_delete
BEFORE DELETE ON game_profile
	FOR EACH ROW EXECUTE FUNCTION fnt_game_profile_trg();
--rollback DROP TRIGGER IF EXISTS game_profile_delete ON game_profile;


-- permissions
--changeset jnolte:20260521_grant_sec_perms_game_profile
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE game_profile TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE game_profile FROM wc_secure_role;


--changeset jnolte:20260521_grant_read_perms_on_game_profile
GRANT SELECT ON TABLE game_profile TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_profile FROM wc_read_only_role;