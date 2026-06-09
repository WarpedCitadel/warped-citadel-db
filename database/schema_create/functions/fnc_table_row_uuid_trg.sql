--liquibase formatted sql


--changeset jnolte:20260604_create_fnc_table_row_uuid_trg splitStatements:false stripComments:false endDelimiter:;
CREATE OR REPLACE FUNCTION fnc_table_row_uuid_trg() RETURNS TRIGGER AS
$func$
BEGIN
	IF (TG_OP = 'UPDATE') THEN
			NEW.img_uuid := uuidv7();
	END IF;

		RETURN NEW;
EXCEPTION
	WHEN OTHERS THEN
		RAISE EXCEPTION 'SQLERRM: Failed to update uuid: %', SQLERRM;
END;
$func$
LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_table_row_uuid_trg() IS
'This function facilitates all object uuid updates to represent change assets
';
--rollback DROP FUNCTION IF EXISTS fnc_table_row_uuid_trg();