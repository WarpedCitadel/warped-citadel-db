/****************************************************************************************
********* YOU NEED TO BE RUNNING AS THE POSTGRES *********
********* ROOT USER TO EXECUTE THIS SQL SCRIPT   *********
*
*Written for PostgreSQL 18.x
*
*Description:
*   This script drops the Warped Citadel database, users, and schema.
*    
*	Edit postgresql.conf.	
*		log_timezone = 'UTC'
*		timezone = 'UTC'
*		client_encoding = UTF8
*		search_path = 'wc01'
*
*Usage:
*    * Excute from /a_warpedcitadel/warped-citadel-db/database/db_rip (For Windows, use WSL. CMD does not recongize :parameters)
*    * Execute as postgreSQL root user: postgres
*    
*    psql.exe --host=localhost --username=postgres --dbname=postgres --echo-all -f rip_database.sql -v vdbname='wc_dev'
*    
* 
****************************************************************************************/

-- ===========================================
-- Connect as superuser postgres
-- ===========================================
\conninfo

-- set parameters for session
\set paramfile :vdbname _parameters.sql
\echo :paramfile
\i ../schema_sec/:paramfile



-- ===========================================
-- Drop the Warped Citadel DATABASE
-- ===========================================
DROP DATABASE IF EXISTS :dbname;


\l+


\du+


-- ===========================================
-- Drop Warped Citadel Database Users 
-- ===========================================
DROP USER IF EXISTS :app_reader_user;

DROP USER IF EXISTS :app_sec_user;

DROP USER IF EXISTS :schema_owner;

\du+


-- ===========================================
-- Drop Warped Citadel Database Roles 
-- ===========================================
DROP ROLE IF EXISTS :app_reader_role;

DROP ROLE IF EXISTS :app_sec_role;

DROP ROLE IF EXISTS :schema_owner_role;

\dg+
