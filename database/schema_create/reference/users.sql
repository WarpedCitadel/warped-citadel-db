--liquibase formatted sql

--changeset jnolte:2020513_create_users
INSERT INTO app_user (uuid, username, password_hash, email, role)
VALUES	('019e2277-92f6-7894-8f01-d5c838efd88f', 'Crom', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'crom@yahoo.com', 1), -- passwords are "Passw0rd!"
		('019e2273-1b32-77c0-b7a6-6ccbd852242b', 'Garf', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'garf@protonmail.com', 2),
		('019e2262-ebd8-7513-ae5e-bfe0ff3a3336', 'Karsius', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'karsius@gmail.com', 3);

