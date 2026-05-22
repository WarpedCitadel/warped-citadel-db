--liquibase formatted sql


--changeset jnolte:2020522_create_users_profile_images
insert into profile_image (user_profile_id, uuid, file_name, file_size)
VALUES (1, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(2, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(3, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(4, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(5, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(6, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(7, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(8, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(9, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(11, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(12, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(13, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(14, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(15, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(16, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(17, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(18, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(19, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(20, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(21, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB'),
	(22, '019e5185-49d8-776c-bbba-78fe34b8b008'::uuid, 'defaultimage.png', '5MB');