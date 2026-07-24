-- liquibase formatted sql


--changeset jnolte:2026072024_create_fnc_search_files_select splitStatements:false stripComments:false endDelimiter:; runOnChange:true
CREATE OR REPLACE FUNCTION fnc_search_files_select(
	p_title				TEXT 	 DEFAULT NULL,
	p_game_profile_uuid	UUID 	 DEFAULT NULL,
	p_status_type_id  	SMALLINT DEFAULT NULL,
	p_platform_id  		SMALLINT DEFAULT NULL
)
RETURNS TABLE(
	app_user_id 		BIGINT,
	game_profile_uuid 	UUID,
	file_uuid 			UUID,
	title 				TEXT,
	file_name 			TEXT,
	file_size 			TEXT,
	platform_id 		SMALLINT,
	status_type_id 		SMALLINT,
	created_dtm 		TIMESTAMP
) AS $func$
DECLARE
	v_base_query 	TEXT;
	v_where_clauses TEXT[] := ARRAY['TRUE'];
	v_final_query 	TEXT;
BEGIN

	v_base_query := '
	WITH main_v AS (
		SELECT
			gp.app_user_id::BIGINT,
			gp.game_profile_uuid::UUID,
			gf.file_uuid::UUID,
			gp.title::TEXT, 
			gf.file_name::TEXT,
			gf.file_size::TEXT,
			gf.platform_id::SMALLINT,
			gf.status_type_id::SMALLINT,
			gf.created_dtm::TIMESTAMP
		FROM wc01.game_file gf
		INNER JOIN wc01.game_profile gp
			ON gf.game_profile_id = gp.id
		UNION ALL
		SELECT
			gp.app_user_id::BIGINT,
			gfs.file_uuid::UUID,
			gp.game_profile_uuid::UUID,
			gp.title::TEXT,
			gfs.file_name::TEXT,
			gfs.file_size::TEXT,
			gfs.platform_id::SMALLINT,
			gfs.status_type_id::SMALLINT,
			gfs.created_dtm::TIMESTAMP 
		FROM wc01.game_file_staging gfs
		INNER JOIN wc01.game_profile gp
			ON gfs.game_profile_id = gp.id
	)
	SELECT m.app_user_id, m.game_profile_uuid, m.file_uuid, m.title, m.file_name, m.file_size, m.platform_id, m.status_type_id, m.created_dtm
	FROM main_v m
	WHERE ';

IF p_title IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.title ilike $1');
END IF;

IF p_game_profile_uuid IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.game_profile_uuid = $2');
END IF;

IF p_status_type_id IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.status_type_id = $3');
END IF;

IF p_platform_id IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.platform_id = $4');
END IF;

v_final_query := v_base_query || array_to_string(v_where_clauses, ' AND ');

RETURN query EXECUTE v_final_query
USING
	p_title || '%',
	p_game_profile_uuid,
	p_status_type_id,
	p_platform_id;

END;
$func$ LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_search_files_select(TEXT, UUID, SMALLINT, SMALLINT) IS '
This function fetches file metadata such as file name, status, and operating system  uploaded to the application 
and dynamically filters the data when the queried inputs are used.
Game title and game profle uuid is available for profile tracking of a particular game.
Lastly, app_user_id is queried to track the the original file uploader for additional tracking.
';


--changeset jnolte:20260724_grant_sec_perms_on_fnc_search_files_select
GRANT EXECUTE ON FUNCTION fnc_search_files_select TO wc_secure_role;
--rollback REVOKE EXECUTE ON FUNCTION fnc_search_files_select FROM wc_secure_role;