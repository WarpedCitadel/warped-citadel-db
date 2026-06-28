--liquibase formatted sql


--changeset jnolte:20260623_create_fnt_game_profile_delete splitStatements:false stripComments:false endDelimiter:;
CREATE OR REPLACE FUNCTION fnt_game_profile_trg() RETURNS TRIGGER AS
$func$
BEGIN
	IF (TG_OP = 'DELETE') THEN

		EXECUTE FORMAT('DELETE FROM wc01.game_platform
						WHERE game_profile_id = %L::INTEGER', OLD.id);

		EXECUTE FORMAT('DELETE FROM wc01.game_file
						WHERE game_profile_id = %L::INTEGER', OLD.id);

		EXECUTE FORMAT('DELETE FROM wc01.game_image
						WHERE game_profile_id = %L::INTEGER', OLD.id);

	END IF;
	RETURN OLD;
EXCEPTION
	WHEN OTHERS THEN
		RAISE EXCEPTION E'SQLERRM: %\nSQLSTATE: %\ngame_profile_delete failed to delete game profile.', SQLERRM, SQLSTATE;
		
END;
$func$
LANGUAGE plpgsql;

COMMENT ON FUNCTION fnt_game_profile_trg() IS
'This function facilitates all table deletions and ensures these game profile and its children are all deleted:

The table expression should look like the following below:

CREATE TRIGGER game_profile_delete
BEFORE DELETE ON game_profile
	FOR EACH ROW EXECUTE FUNCTION fnt_game_profile_trg();
';
--rollback DROP FUNCTION IF EXISTS fnt_game_profile_trg();