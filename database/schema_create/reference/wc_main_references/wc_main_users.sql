--liquibase formated sql


--changeset jnolte:2020614_create_wc_main_users
insert into app_user (username, password_hash, email, role) values ('jaegernolte@warpedcitadel.com', '$2a$04$dLb5GaPF1D5hJ.KTFE24aO9gIpCeRllciiA482Axt4xqIjqR2lSey', 'jaegernolte@warpedcitadel.com', 3);
insert into app_user (username, password_hash, email, role) values ('jaredwood@warpedcitadel.com', '$2a$04$dLb5GaPF1D5hJ.KTFE24aO9gIpCeRllciiA482Axt4xqIjqR2lSey', 'jaredwood@warpedcitadel.com', 3);
insert into app_user (username, password_hash, email, role) values ('kadenmisenheimer@warpedcitadel.com', '$2a$04$dLb5GaPF1D5hJ.KTFE24aO9gIpCeRllciiA482Axt4xqIjqR2lSey', 'kadenmisenheimer@warpedcitadel.com', 3);
insert into app_user (username, password_hash, email, role) values ('williamgillenwaters@warpedcitadel.com', '$2a$04$WN9VNwgQu1s151/IUYzwXOChbfBP2UrdvNSa.MUaDi1RkOHr0AIHq', 'williamgillenwaters@warpedcitadel.com', 2);
insert into app_user (username, password_hash, email, role) values ('johnblanche@warpedcitadel.com', '$2a$04$WN9VNwgQu1s151/IUYzwXOChbfBP2UrdvNSa.MUaDi1RkOHr0AIHq', 'johnblanche@warpedcitadel.com', 2);
insert into app_user (username, password_hash, email, role) values ('GarfTheBard', '$2a$04$WN9VNwgQu1s151/IUYzwXOChbfBP2UrdvNSa.MUaDi1RkOHr0AIHq', 'GarfTheBard@gmail.com', 1);
insert into app_user (username, password_hash, email, role) values ('Spopa', '$2a$04$WN9VNwgQu1s151/IUYzwXOChbfBP2UrdvNSa.MUaDi1RkOHr0AIHq', 'Spopa@gmail.com', 1);
insert into app_user (username, password_hash, email, role) values ('Musashi', '$2a$04$WN9VNwgQu1s151/IUYzwXOChbfBP2UrdvNSa.MUaDi1RkOHr0AIHq', 'Musahi@gmail.com', 1);