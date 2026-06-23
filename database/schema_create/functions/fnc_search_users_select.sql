-- liquibase formatted sql


--changeset jnolte:20260529_create_fnc_search_users_select splitStatements:false stripComments:false endDelimiter:; runOnChange:true
CREATE OR REPLACE FUNCTION fnc_search_users_select(
	p_display_name 	TEXT 	DEFAULT NULL,
	p_role			TEXT 	DEFAULT NULL,
	p_status		BOOLEAN DEFAULT NULL
)
RETURNS TABLE(
	user_uuid 		UUID,
	app_user_id 	INTEGER,
	img_uuid 		UUID,
	display_name 	TEXT,
	email 			TEXT,
	role_type 		TEXT,
	isactive 		BOOLEAN,
	created_dtm 	TEXT
) AS $func$
DECLARE
	v_base_query 	TEXT;
	v_where_clauses TEXT[] := ARRAY['TRUE'];
	v_final_query 	TEXT;
BEGIN

	v_base_query := '
	WITH main_v AS (
		SELECT
			au.user_uuid::UUID,
			aup.app_user_id::INTEGER,
			pi.img_uuid::UUID,
			COALESCE(aup.display_name, au.username)::TEXT
				AS display_name,
			au.email::TEXT,
			r.role_type::TEXT,
			au.isactive::BOOLEAN,
			au.created_dtm::TEXT
		FROM wc01.app_user au
		LEFT JOIN wc01.app_user_profile aup
			ON au.id = aup.app_user_id
		LEFT JOIN wc01.role r
			ON au.role = r.id
		LEFT JOIN wc01.profile_image pi
			ON aup.id = pi.app_user_profile_id
	)
	SELECT m.user_uuid, m.app_user_id, m.img_uuid, m.display_name, m.email, m.role_type, m.isactive, m.created_dtm
	FROM main_v m
	WHERE ';

IF p_display_name IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.display_name ilike $1');
END IF;

IF p_role IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.role_type = $2');
END IF;

IF p_status IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.isactive = $3');
END IF;


v_final_query := v_base_query || array_to_string(v_where_clauses, ' AND ');

RETURN query EXECUTE v_final_query
USING
	p_display_name || '%',
	p_role,
	P_status;

END;
$func$ LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_search_users_select(TEXT, TEXT, BOOLEAN) IS '
fetches app user profile such as the users status and role inside the application.

The function provides dynamically search sorting functionality based on user roles and isactive statuses.
';


--changeset jnolte:20260529_grant_sec_perms_on_fnc_get_mgt_user_group_select
GRANT EXECUTE ON FUNCTION fnc_search_users_select TO wc_secure_role;
--rollback REVOKE EXECUTE ON FUNCTION fnc_search_users_select FROM wc_secure_role;