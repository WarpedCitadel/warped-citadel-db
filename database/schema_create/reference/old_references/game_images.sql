-- liquibase formatted sql


--changeset jnolte:2020521_create_game_images
insert into game_image (game_profile_id, iscover, file_name, file_size)
VALUES (1, true, 'thumbnail.png', '15KB'),
		(1, false, 'farm.png', '8KB'),
		(1, false, 'casino.jpg', '5KB'),
		(1, false, 'bar.png', '9KB'),
		(1, false, 'homescreen.png', '16KB'),
		(1, false, 'pickaxe.png', '5KB'),
		(2, true, 'icecave.png', '15KB'),
		(2, false, 'igloo.png', '8KB'),
		(2, false, 'map.png', '32KB'),
		(2, false, 'vibes.png', '15KB'),
		(2, false, 'cave_entrance.png', '23KB'),
		(2, false, 'combat.png', '5KB'),
		(3, true, 'plantgame.png', '15KB'),
		(3, false, 'space.png', '8KB'),
		(3, false, 'jump.jpg', '5KB'),
		(3, false, 'blackhole.png', '15KB'),
		(3, false, 'houston.png', '22KB'),
		(3, false, 'dialogue.png', '15KB');