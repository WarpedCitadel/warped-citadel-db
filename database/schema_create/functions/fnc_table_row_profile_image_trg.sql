--liquibase formatted sql


--changeset jnolte:20260713_create_fnc_table_row_profile_image_trg splitStatements:false stripComments:false endDelimiter:;
CREATE OR REPLACE FUNCTION fnc_table_row_profile_image_trg() RETURNS TRIGGER AS 
$func$
DECLARE

	image_name_array TEXT[] := ARRAY['9d047469-080d-4c06-912d-8b9aec684e0b.png'];
	image_uuid_array UUID[] := ARRAY['019f7b16-635a-7c13-b15d-ed3c75ad61f9'];
	image_size_array TEXT[] := ARRAY['1KB'];
	random_index INT;

BEGIN

	IF (TG_OP = 'INSERT') THEN

		random_index := FLOOR(RANDOM() * ARRAY_LENGTH(image_name_array, 1)) + 1;
			
		INSERT INTO wc01.profile_image (
			app_user_profile_id,
			file_name,
			img_uuid,
			file_size
			)
		VALUES (
			NEW.id,
			image_name_array[random_index],
			image_uuid_array[random_index],
			image_size_array[random_index]
			);

	END IF;

	RETURN NEW;
EXCEPTION
	WHEN OTHERS THEN
		RAISE EXCEPTION 'SQLERRM: Failed to set image fields: %', SQLERRM;
END;
$func$
LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_table_row_profile_image_trg() IS
'This function facilitates all table row-level default images and ensures these image columns are set:
	file_name
	img_uuid
	file_size
';
--rollback DROP FUNCTION IF EXISTS fnc_table_row_profile_image_trg();