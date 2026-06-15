--liquibase formatted sql

--changeset jnolte:20260614_create_game_type
CREATE TABLE game_type (
	id 				SERIAL			NOT NULL PRIMARY KEY,
	game_type_name	VARCHAR(20)		NOT NULL
);


-- create game types
INSERT INTO game_type (id, game_type_name)
VALUES	(1, 'HTML5'),
		(2, 'Downloadable');


COMMENT ON TABLE game_type IS 'static data for game types';
--rollback DROP TABLE IF EXISTS game_type;


-- permissions
--changeset jnolte:20260614_grant_sec_perms_game_type
GRANT SELECT ON TABLE game_type TO wc_secure_role;
--rollback REVOKE SELECT ON TABLE game_type FROM wc_secure_role;


--changeset jnolte:20260614_grant_read_perms_on_game_type
GRANT SELECT ON TABLE game_type TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE game_type FROM wc_read_only_role;