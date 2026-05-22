-- liquibase formatted SQL

--changeset jnolte:2020521_create_app_files
INSERT INTO app_file (app_user_id, file_name, file_version, file_size, status_type_id)
VALUES (22, 'index.audio.worklet.zip', '1.0.0', '10MB', 4),
		(5, 'IceCave1.1.zip', '1.1.0', '34MB', 4),
		(4, 'planetgame.zip', '1.2.6', '372MB', 4);
		