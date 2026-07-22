-- liquibase formatted sql

--changeset jnolte:20260719_create_game_image_staging
CREATE TABLE game_image_staging (
	id					SERIAL			NOT NULL PRIMARY KEY,
	game_profile_id		BIGINT			NOT NULL REFERENCES game_profile (id),
	img_uuid			UUID			NOT NULL DEFAULT uuidv7(),
	iscover				BOOLEAN			NOT NULL DEFAULT FALSE,
	file_name			varchar(100)	NOT NULL,
	file_size			varchar(7)		NOT NULL,
	created_dtm			TIMESTAMP(6)	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);


COMMENT ON TABLE game_image_staging IS 'reference images for game profile';
--rollback DROP TABLE IF EXISTS game_image_staging;


-- sequence
--changeset jnolte:20260719_restart_game_image_staging_id_seq
ALTER SEQUENCE game_image_staging_id_seq
 INCREMENT BY 1
 START WITH 1
 RESTART WITH 1
 NO MAXVALUE
 NO MINVALUE
 CACHE 1
 NO CYCLE;
--xrollback DROP SEQUENCE IF EXISTS game_image_staging_id_seq;
--rollback not required


-- permissions
--changeset jnolte:20260719_grant_sec_perms_game_image_staging
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE game_image_staging TO wc_secure_role;
GRANT USAGE ON SEQUENCE game_image_staging_id_seq TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE game_image_staging FROM wc_secure_role;
--rollback REVOKE USAGE ON SEQUENCE game_image_staging_id_seq FROM wc_secure_role;


--changeset jnolte:20260719_grant_read_perms_on_game_image_staging
GRANT SELECT ON TABLE game_image_staging TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_image_staging FROM wc_read_only_role;