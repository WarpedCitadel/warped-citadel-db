--liquibase formatted sql


--changeset jnolte:20260625_create_fnc_table_row_audit_trg splitStatements:false stripComments:false endDelimiter:;
CREATE OR REPLACE FUNCTION fnc_table_row_audit_trg() RETURNS TRIGGER AS 
$func$
BEGIN
	IF (TG_OP = 'UPDATE') THEN
			New.modified_dtm := CURRENT_TIMESTAMP(6) AT TIME ZONE 'UTC';
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