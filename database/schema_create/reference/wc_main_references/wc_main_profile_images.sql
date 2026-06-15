--liquibase formatted sql


--changeset jnolte:2020614_create_wc_main_profile_images
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (1, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (2, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (3, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (4, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (5, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (6, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (7, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');
insert into profile_image (app_user_profile_id, img_uuid, file_name, file_size) values (8, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');