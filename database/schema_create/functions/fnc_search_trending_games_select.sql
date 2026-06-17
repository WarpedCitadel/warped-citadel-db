-- liquibase formatted sql


--changeset jnolte:20260616_create_fnc_search_trending_games_select splitStatements:false stripComments:false endDelimiter:; runOnChange:true
CREATE OR REPLACE FUNCTION fnc_search_trending_games_select(
	p_title 		TEXT 	DEFAULT NULL,
	p_game_genre_id	INTEGER DEFAULT	NULL,
	p_platform_os	TEXT[]	DEFAULT NULL,
	p_most_recent	INTEGER	DEFAULT NULL
)
RETURNS TABLE(
	game_profile_id			INTEGER,
	game_profile_uuid 		UUID,
	img_uuid				UUID,
	title					TEXT,
	short_desc				TEXT,
	game_genre_id			INTEGER,
	platform_os				TEXT[],
	created_dtm				TIMESTAMP
) AS $func$
DECLARE
	v_base_query 	TEXT;
	v_where_clauses TEXT[] := ARRAY['TRUE'];
	v_final_query 	Text;
BEGIN

	v_base_query := '
	WITH main_v AS (
		SELECT
			gp.id::INTEGER as game_profile_id,
			gp.game_profile_uuid::UUID,
			gi.img_uuid::UUID as cover_img,
			gp.title::TEXT,
			gp.short_desc::TEXT,
			gp.game_genre_id::INTEGER,
			os.platform_os::TEXT[],
			gp.created_dtm::TIMESTAMP
		FROM wc01.game_profile gp
	LEFT JOIN (
		SELECT
			gpm.game_profile_id,
			array_agg(p.platform_type) as platform_os
	FROM wc01.game_platform gpm
	INNER JOIN wc01.platform p
		ON gpm.platform_id = p.id
	GROUP BY
			gpm.game_profile_id
		) os ON gp.id = os.game_profile_id
	LEFT JOIN wc01.game_file gf
		ON gf.game_profile_id = gp.id
		and gf.status_type_id = 4
	LEFT JOIN wc01.game_image gi
		ON gi.game_profile_id = gp.id
		and gi.iscover = true
		)
		SELECT
			m.game_profile_id,
			m.game_profile_uuid,
			m.cover_img,
			m.title,
			m.short_desc,
			m.game_genre_id,
			m.platform_os,
			m.created_dtm
	FROM main_v m
	WHERE ';

IF p_title IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.title ilike $1');
END IF;

IF p_game_genre_id >= 1 AND p_game_genre_id IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.game_genre_id = $2');
END IF;

IF p_platform_os IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.platform_os @> $3');
END IF;

IF p_most_recent = 1 AND p_most_recent IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.created_dtm >= (NOW() AT TIME ZONE ''UTC'') - INTERVAL ''30 days'' ');
END IF;

IF p_most_recent = 2 AND p_most_recent IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.created_dtm >= (NOW() AT TIME ZONE ''UTC'') - INTERVAL ''7 days'' ');
END IF;

IF p_most_recent = 3 AND p_most_recent IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.created_dtm >= (NOW() AT TIME ZONE ''UTC'') - INTERVAL ''1 days'' ');
END IF;

v_final_query := v_base_query || array_to_string(v_where_clauses, ' AND ');

RETURN query EXECUTE v_final_query
USING
	p_title || '%',
	p_game_genre_id,
	ARRAY[p_platform_os],
	p_most_recent;

END;
$func$ LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_search_trending_games_select(TEXT, INTEGER, TEXT[], INTEGER) IS '
fetches game profiles for applications main page.

The function provides dynamically searched by sorting based on title searches, genre types, most recent, and OS compatibility.
';


--changeset jnolte:20260614_grant_sec_perms_on_fnc_search_trending_games_select
GRANT EXECUTE ON FUNCTION fnc_search_trending_games_select TO wc_secure_role;
--rollback REVOKE EXECUTE ON FUNCTION fnc_search_trending_games_select FROM wc_secure_role;