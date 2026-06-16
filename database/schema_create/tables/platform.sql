--liquibase formatted sql

--changeset jnolte:20260614_create_platform
CREATE TABLE platform (
	id 				SERIAL			NOT NULL PRIMARY KEY,
	platform_type	VARCHAR(2)		NOT NULL
);


-- create game platforms
INSERT INTO platform (id, platform_type)
VALUES	(1, 'B'),
		(2, 'W'),
		(3, 'L'),
		(4, 'M');


COMMENT ON TABLE platform IS 'static data for game platforms';
--rollback DROP TABLE IF EXISTS platform;


-- permissions
--changeset jnolte:20260614_grant_sec_perms_platform
GRANT SELECT ON TABLE platform TO wc_secure_role;
--rollback REVOKE SELECT ON TABLE platform FROM wc_secure_role;


--changeset jnolte:20260614_grant_read_perms_on_platform
GRANT SELECT ON TABLE platform TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE platform FROM wc_read_only_role;