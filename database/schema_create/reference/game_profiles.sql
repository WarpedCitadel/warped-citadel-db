-- liquibase formatted sql


--changeset jnolte:2020521_create_game_files
INSERT INTO game_profile (app_file_id, title, description, genre_id)
VALUES (1, 'Gold Rush', 'The text is very blurry if it is not Fullscreen, so I highly recommend Fullscreen.
For the gamejam it is western because the gold rush in California is one of the leading contributions to starting the western era.', 9),
		(2, 'IceCave', 'Controls:
WASD to move
Spacebar to push boxes
Click on water to freeze/unfreeze it (3 frozen things max)
Escape to close the game

Collect all 4 snowflakes to enter the Ice Cave!

Made for the 2024 Winter Texas State GDS Game Jam

Credits:
Spopa - Programming
BigManJD - Programming & Art

Thanks for playing!', 4),
		(3, 'PlanetGame', 'The galaxy is vast an full of wonders.

In this game, you take on the role of Houston - a dragonborn astronaut who dreams of exploring the galaxy, every wonder and every horror.

Use A and D to move left and right. SPACE to jump, and SHIFT activates your breth weapon. This launches you in the opposite direction you aim it in.

There are gravity fields and planets that change what direction down is. Remember in space, there is no such thing as down.

Note: This is a Tech Demo - just to showcase the gravity mechanics. Hopefully, I can develop it into a full game.', 3);