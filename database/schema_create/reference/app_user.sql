BEGIN;

insert into app_user (id, username, email, password_hash, isverified) values (1, 'jaeger@warpedcitadel.com', 'jaeger.nolte@gmail.com', '$2a$10$FbYjv1QzVwHJ0rQimOT2Y.EnP4pIla2rpv2l0xKlejN1khAUMHHvO', true);
insert into app_user (id, username, email, password_hash, isverified) values (2, 'jared@warpedcitadel.com', 'jaredwood002@gmail.com', '$2a$10$eeDD3jh6nga44kaXsyeksePdVlewniriVAt.Iq/avT0XzK/MyDvTC', true);
insert into app_user (id, username, email, password_hash, isverified) values (3, 'kaden@warpedcitadel.com', 'kadenmisenheimer@gmail.com', '$2a$10$9fFx9BQwmZmBey2Cfix6BOYvSTLctEYZYln.IcjKYXasJS74y2GZi', true);
insert into app_user (id, username, email, password_hash, isverified) values (4, 'will@warpedcitadel.com', 'will@gmail.com', '$2a$10$p/1mahqciuZIXSadV3GAqOcWqqxfVgktJftZ7uUoX4gM75IgzgsgO', true);
insert into app_user (id, username, email, password_hash, isverified) values (5, 'testUser1', 'testuser1@gmail.com', '$2a$12$lz81XP.71trPoHsVJA3AMuIQZwEy.3G95PsumpbhS/3ra2tnSGKc.', true);

SELECT setval('app_user_id_seq', (SELECT MAX(id) FROM app_user));
COMMIT;