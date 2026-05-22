-- liquibase formatted sql

--changeset jnolte:20260521_create_genre
CREATE TABLE genre (
	id 		SERIAL		NOT NULL PRIMARY KEY,
	genre_type	VARCHAR(20)	NOT NULL
);


-- create game genres
INSERT INTO genre (id, genre_type)
VALUES	(1, 'Action'),
		(2, 'Adventure'),
		(3, 'Platformer'),
		(4, 'Role playing'),
		(5, 'Surival'),
		(6, 'Racing'),
		(7, 'Strategy'),
		(8, 'Puzzle'),
		(9, 'Simulation'),
		(10, 'Sports');


COMMENT ON TABLE genre IS 'static data for game genres';
--rollback DROP TABLE IF EXISTS genre;


-- permissions
--changeset jnolte:20260521_grant_sec_perms_genre
GRANT SELECT ON TABLE genre TO wc_secure_role;
--rollback REVOKE SELECT ON TABLE genre FROM wc_secure_role;


--changeset jnolte:20260521_grant_read_perms_on_genre
GRANT SELECT ON TABLE genre TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE genre FROM wc_read_only_role;