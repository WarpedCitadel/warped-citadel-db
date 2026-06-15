-- liquibase formatted sql


--changeset jnolte:20260614_create_fnc_search_trending_games_select splitStatements:false stripComments:false endDelimiter:; runOnChange:true
CREATE OR REPLACE FUNCTION fnc_search_trending_games_select(
	p_title 	TEXT 	DEFAULT NULL,
	p_genre_id	INTEGER DEFAULT	NULL
)
RETURNS TABLE(
	file_uuid 	UUID,
	file_id 	INTEGER,
	img_uuid	UUID,
	title		TEXT,
	short_desc	TEXT,
	genre_id	INTEGER,
	created_dtm	TEXT
) AS $func$
DECLARE
	v_base_query 	TEXT;
	v_where_clauses TEXT[] := ARRAY['TRUE'];
	v_final_query 	Text;
BEGIN

	v_base_query := '
	WITH main_v AS (
			select
			af.file_uuid::UUID,
			af.id::INTEGER AS file_id,
			gi.img_uuid::UUID AS cover_img,
			gp.title::TEXT,
			gp.short_desc::TEXT,
			g.id::INTEGER AS genre_id,
			gp.created_dtm::TEXT
		from wc01.app_file af
	left join wc01.game_profile gp
		on gp.app_file_id = af.id
	left join wc01.game_image gi
		on gi.game_profile_id = gp.id
	left join wc01.genre g
		on g.id = gp.genre_id
	where gi.iscover = true
	and af.status_type_id = 4
	)
	SELECT m.file_uuid, m.file_id, m.cover_img, m.title, m.short_desc, m.genre_id, m.created_dtm
	FROM main_v m
	WHERE ';

IF p_title IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.title ilike $1');
END IF;

IF p_genre_id >= 1 AND p_genre_id IS NOT NULL THEN
	v_where_clauses := array_append(v_where_clauses, 'm.genre_id = $2');
END IF;


v_final_query := v_base_query || array_to_string(v_where_clauses, ' AND ');

RETURN query EXECUTE v_final_query
USING
	p_title || '%',
	p_genre_id;

END;
$func$ LANGUAGE plpgsql;


COMMENT ON FUNCTION fnc_search_trending_games_select(TEXT, INTEGER) IS '
fetches game profiles for applications main page.

The function provides dynamically search sorting functionality based on titles and genres.
';


--changeset jnolte:20260614_grant_sec_perms_on_fnc_search_trending_games_select
GRANT EXECUTE ON FUNCTION fnc_search_trending_games_select TO wc_secure_role;
--rollback REVOKE EXECUTE ON FUNCTION fnc_search_trending_games_select FROM wc_secure_role;