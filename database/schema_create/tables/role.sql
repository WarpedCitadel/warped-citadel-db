--liquibase formatted sql

--changeset jnolte:20260507_create_role
CREATE TABLE role (
 id 		SERIAL 	PRIMARY KEY,
 role_type 	VARCHAR(5) 	NOT NULL
 CONSTRAINT cap_id CHECK (id <= 4)
);

COMMENT ON TABLE role IS 'list of user roles for the platform';
--rollback DROP TABLE IF EXISTS role;


-- create platform roles
INSERT INTO role (role_type) VALUES ('anon'), ('user'), ('mod'), ('admin');

-- permissions
--changeset jnolte:20260506_grant_sec_perms_role
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE role TO wc_secure_role;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLE role FROM wc_secure_role;


--changeset jnolte:20260506_grant_read_perms_on_role
GRANT SELECT ON TABLE role TO wc_read_only_role;
--rollback REVOKE SELECT ON TABLE role FROM wc_read_only_role;
