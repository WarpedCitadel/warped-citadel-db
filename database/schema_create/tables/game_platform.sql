--liquibase formatted sql

--changeset jnolte:20260614_create_game_platform
CREATE TABLE game_platform (
	id 				SERIAL			NOT NULL PRIMARY KEY,
	platform_type	VARCHAR(20)		NOT NULL
);


-- create game platforms
INSERT INTO game_platform (id, platform_type)
VALUES	(1, 'Play in browser'),
		(2, 'Windows'),
		(3, 'Linux'),
		(4, 'MacOs');


COMMENT ON TABLE game_platform IS 'static data for game platforms';
--rollback DROP TABLE IF EXISTS game_platform;


-- permissions
--changeset jnolte:20260614_grant_sec_perms_game_platform
GRANT SELECT ON TABLE game_platform TO wc_secure_role;
--rollback REVOKE SELECT ON TABLE game_platform FROM wc_secure_role;


--changeset jnolte:20260614_grant_read_perms_on_game_type
GRANT SELECT ON TABLE game_platform TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_platform FROM wc_read_only_role;