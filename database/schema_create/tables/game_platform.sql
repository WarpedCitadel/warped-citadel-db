--liquibase formatted sql

--changeset jnolte:20260616_create_game_platform
CREATE TABLE game_platform (
 id 				SERIAL 		NOT NULL PRIMARY KEY,
 platform_id 		SMALLINT	NOT NULL REFERENCES platform (id),
 game_profile_id 	BIGINT		NOT NULL REFERENCES game_profile (id),
 CONSTRAINT unique_game_platform UNIQUE (platform_id, game_profile_id)
);


COMMENT ON TABLE game_platform IS 'static data for game platforms';
--rollback DROP TABLE IF EXISTS game_platform;


-- sequence
--changeset jnolte:20260627_restart_game_platform_id_seq
ALTER SEQUENCE game_platform_id_seq
 INCREMENT BY 1
 START WITH 1
 RESTART WITH 1
 NO MAXVALUE
 NO MINVALUE
 CACHE 1
 NO CYCLE;
--xrollback DROP SEQUENCE IF EXISTS game_platform_id_seq;
--rollback not required


-- permissions
--changeset jnolte:20260614_grant_sec_perms_game_platform
GRANT SELECT ON TABLE game_platform TO wc_secure_role;
GRANT USAGE ON SEQUENCE game_platform_id_seq TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE game_platform FROM wc_secure_role;
--rollback REVOKE USAGE ON SEQUENCE game_platform_id_seq FROM wc_secure_role;


--changeset jnolte:20260614_grant_read_perms_on_game_platform
GRANT SELECT ON TABLE game_platform TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_platform FROM wc_read_only_role;