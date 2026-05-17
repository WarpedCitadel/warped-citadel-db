--liquibase formatted sql


--changeset jnolte:2020516_create_users_profiles
INSERT INTO wc01.app_user_profile (app_user_id, display_name, user_bio)
VALUES ( 1, 'Jaeger Nolte', 'Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id cursus mi.'),
		( 2, 'Jared Wood', 'Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id cursus mi.'),
		( 3, 'Kaden Misenheimer', 'Lorem ipsum dolor sit amet consectetur adipiscing elit quisque faucibus ex sapien vitae pellentesque sem placerat in id cursus mi.');