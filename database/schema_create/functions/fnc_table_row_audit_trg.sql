--liquibase formatted sql


--changeset jnolte:20260625_create_fnc_table_row_audit_trg splitStatements:false stripComments:false endDelimiter:;
CREATE OR REPLACE FUNCTION fnc_table_row_audit_trg() RETURNS TRIGGER AS 
$func$
BEGIN
	IF (LOWER(TG_TABLE_NAME) != 'app_user_audit') THEN
	
		IF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
				NEW.modified_dtm := CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC';
		END IF;
	ELSE

		IF (TG_OP = 'INSERT') THEN
				NEW.lastactive_dtm := CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC';
		END IF;
	END IF;

	RETURN NEW;
EXCEPTION
	WHEN OTHERS THEN
		RAISE EXCEPTION 'SQLERRM: Failed to set audit fields: %', SQLERRM;
END;
$func$
LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_table_row_audit_trg() IS
'This function facilitates all table row-level auditing and ensures these audit columns are set:
	modified_dtm
';
--rollback DROP FUNCTION IF EXISTS fnc_table_row_audit_trg();