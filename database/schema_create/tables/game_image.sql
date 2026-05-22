-- liquibase formatted sql

--changeset jnolte:20260521_create_game_image
CREATE TABLE game_image (
	id					SERIAL			NOT NULL PRIMARY KEY,
	game_profile_id		BIGINT			NOT NULL REFERENCES game_profile (id),
	uuid				UUID			NOT NULL DEFAULT uuidv7(),
	iscover				BOOLEAN			NOT NULL DEFAULT FALSE,
	file_name			varchar(100)	NOT NULL,
	file_size			varchar(7)		NOT NULL,
	created_dtm			TIMESTAMP(6)	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE game_image IS 'reference images for game profile';
--rollback DROP TABLE IF EXISTS game_image;


-- permissions
--changeset jnolte:20260521_grant_sec_perms_game_image
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE game_image TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE game_image FROM wc_secure_role;


--changeset jnolte:20260521_grant_read_perms_on_game_image
GRANT SELECT ON TABLE game_image TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_image FROM wc_read_only_role;