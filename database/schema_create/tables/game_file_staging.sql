--liquibase formatted sql

--changeset jnolte:20260720_create_game_file_staging
CREATE TABLE game_file_staging (
  id 					SERIAL 			NOT NULL PRIMARY KEY,
  game_profile_id		BIGINT			NOT NULL REFERENCES game_profile (id),
  file_uuid				UUID			NOT NULL DEFAULT uuidv7(),
  file_name 			VARCHAR(100)	NOT NULL,
  file_size 			VARCHAR(7)		NOT NULL,
  platform_id			SMALLINT		NOT NULL REFERENCES platform (id),
  status_type_id 		SMALLINT 		NOT NULL REFERENCES status_type (id) DEFAULT 1,
  created_dtm 			TIMESTAMP(6) 	NOT NULL DEFAULT (CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC')
);

COMMENT ON TABLE game_file_staging IS 'Object metadata for game file uploads for the platform.';
--rollback DROP TABLE IF EXISTS game_file_staging;


--changeset jnolte:20260720_create_game_file_staging_uk01 runInTransaction:false
CREATE UNIQUE INDEX CONCURRENTLY game_file_staging_uk01 ON game_file_staging(file_uuid);


-- sequence
--changeset jnolte:20260720_restart_game_file_staging_id_seq
ALTER SEQUENCE game_file_staging_id_seq
 INCREMENT BY 1
 START WITH 1
 RESTART WITH 1
 NO MAXVALUE
 NO MINVALUE
 CACHE 1
 NO CYCLE;
--xrollback DROP SEQUENCE IF EXISTS game_file_staging_id_seq;
--rollback not required


-- permissions
--changeset jnolte:20260720_grant_sec_perms_game_file_staging
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE game_file_staging TO wc_secure_role;
GRANT USAGE ON SEQUENCE game_file_staging_id_seq TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE game_file_staging FROM wc_secure_role;
--rollback REVOKE USAGE ON SEQUENCE game_file_staging_id_seq FROM wc_secure_role;


--changeset jnolte:20260720_grant_read_perms_on_game_file_staging
GRANT SELECT ON TABLE game_file_staging TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_file_staging FROM wc_read_only_role;