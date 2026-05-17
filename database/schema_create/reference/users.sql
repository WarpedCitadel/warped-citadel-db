--liquibase formatted sql


--changeset jnolte:2020513_create_users
INSERT INTO app_user (uuid, username, password_hash, email, role)
VALUES	('019e372d-5097-76fc-98c9-0db5174d7d62', 'WCADMIN', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'warpedCitadeladmin@gmail.com', 3), -- passwords are "Passw0rd!"
		('019e372d-5613-727a-baa2-3c23fabf5f64', 'WCMOD', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'warpedCitadelmod@gmail.com', 2),
		('019e2277-92f6-7894-8f01-d5c838efd88f', 'Crom', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'crom@yahoo.com', 1),
		('019e2273-1b32-77c0-b7a6-6ccbd852242b', 'Garf', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'garf@protonmail.com', 1),
		('019e2262-ebd8-7513-ae5e-bfe0ff3a3336', 'Karsius', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'karsius@gmail.com', 1),
		('019e372d-4df6-704e-bb71-a7212d47f661', 'Shan', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'shan@gmail.com', 1),
		('019e372d-4e37-7111-9144-f329286100c2', 'Eliphas', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'eliphas@gmail.com', 1),
		('019e372d-4e74-7388-a3ab-eb9205399546', 'Chromicon', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'chromicon@gmail.com', 1),
		('019e372d-65b5-775f-8ed7-7b2d470efe49', 'Olvard', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'olvard@gmail.com', 1),
		('019e372d-6809-78a5-af45-37313fbbb1e4', 'Sigismund', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'sigismund@gmail.com', 1),
		('019e372d-6a61-7870-a9c8-d1c1d3706e7a', 'Coal', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'coal@gmail.com', 1),
		('019e372d-7fcb-73e8-8f2a-587e55cd553d', 'Peturabo', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'peturabo@gmail.com', 1),
		('019e372d-807a-7f77-856c-031e3754a05a', 'Mortarion', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'mortarion@gmail.com', 1),
		('019e372d-8552-79bf-925f-c484448b501b', 'Angron', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'angron@gmail.com', 1),
		('019e372d-8603-7572-8d09-dd0cdf63897d', 'Sanguinius', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'sanguinius@gmail.com', 1),
		('019e372d-8889-7bf1-bd24-9b687234158a', 'Jagatai', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'jagatai@gmail.com', 1),
		('019e372d-893b-76e7-9036-1eca29a61905', 'Garviel', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'garviel.loken@gmail.com', 1),
		('019e372d-8976-7cf1-a08c-059f5560c25c', 'Magnus', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'magnus@gmail.com', 1),
		('019e372d-7edf-7fa4-adfe-8d82efc9c79d', 'Nathaniel', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'nathaniel@gmail.com', 1),
		('019e372d-6a26-7581-b213-ce7f54761774', 'Erobus', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'erobus@gmail.com', 1),
		('019e372d-6a9e-7364-8eb7-477f9c6b42ee', 'Argal', '$2a$10$G8EtHS5Oa/5rPwFDTRYQwOjFCqMxeGmSv.jx7THssGpi3Qn0Op6QW', 'argal@gmail.com', 1);
