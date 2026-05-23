--liquibase formatted sql


--changeset jnolte:2020523_create_wc_users
INSERT INTO app_user (uuid, username, password_hash, email, role)
VALUES	('019e372d-5097-76fc-98c9-0db5174d7d62', 'WCADMIN', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'jaeger.warpedCitadeladmin@gmail.com', 3), -- passwords are "Passw0rd!"
		('019e372d-5613-727a-baa2-3c23fabf5f64', 'WCMOD1', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'jared.warpedCitadelmod@gmail.com', 2),
		('019e372d-5613-727a-baa2-3c23fabf7f64', 'WCMOD2', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'kaden.warpedCitadelmod@gmail.com', 2);
