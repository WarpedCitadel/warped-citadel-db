--liquibase formatted sql

--changeset jnolte:20260616_create_game_platform
CREATE TABLE game_platform (
 id 				SERIAL 	NOT NULL PRIMARY KEY,
 platform_id 	BIGINT	NOT NULL REFERENCES platform (id),
 game_profile_id 	BIGINT	NOT NULL REFERENCES game_profile (id)
);


COMMENT ON TABLE game_platform IS 'static data for game platforms';
--rollback DROP TABLE IF EXISTS game_platform;


-- permissions
--changeset jnolte:20260614_grant_sec_perms_game_platform
GRANT SELECT ON TABLE game_platform TO wc_secure_role;
--rollback REVOKE SELECT ON TABLE game_platform FROM wc_secure_role;


--changeset jnolte:20260614_grant_read_perms_on_game_platform
GRANT SELECT ON TABLE game_platform TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_platform FROM wc_read_only_role;