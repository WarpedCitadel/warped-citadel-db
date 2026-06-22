/*************************************************************************************************
********* YOU NEED TO BE RUNNING AS THE POSTGRES *********
********* ROOT USER TO EXECUTE THIS SQL SCRIPT   *********
*
*Written for PostgreSQL 18.x
*
*Description:
*   This script creates the Warped Citadel Core database, users, and schema.
*
*   Edit postgresql.conf.
*       log_timezone = 'UTC'
*       timezone = 'UTC'
*       client_encoding = UTF8
*       search_path = 'wc01'
*
*Usage:
*   * Execute from /a_warpedcitadel/warped-citadel-db/database/db_create (For Windows, use WSL. CMD does not recongize :parameters)
*   * Execute as PostgresSQL root user: postgres
*
*     psql.exe --host=localhost --username=postgres --dbname=postgres --echo-all -f create_database.sql -v vdbname='wc_dev'
*
*
************************************************************************************************/

-- ===========================================
-- Connect as superuser postgres
-- ===========================================
\conninfo

-- Set parameters for session
\set paramfile :vdbname _parameters.sql
\echo :paramfile
\i ../schema_sec/:paramfile


-- ===========================================
-- postgres: Drop Public Schema from postgres Database
-- ===========================================
DROP SCHEMA IF EXISTS public CASCADE;


-- ===========================================
-- postgres: Create Roles
-- ===========================================
/* create Database Owner Role */
Create Role :schema_owner_role;

/* Create Secure Role */
Create Role :app_sec_role;

/* Create Read Only Role */
Create Role :app_reader_role;


-- ===========================================
-- postgres: Create Users
-- ===========================================
/* Create Database Owner User (dbo_wc) */
Create USER :schema_owner WITH
    LOGIN
    ENCRYPTED PASSWORD :'schema_owner_pwd'
    CREATEDB
    CREATEROLE;

GRANT :schema_owner_role TO :schema_owner;


SELECT COUNT(0) = 1 AS localhost WHERE inet_server_addr() = '127.0.0.1' OR inet_server_addr() = '::1'
\gset
\if :localhost
    -- NOTE: Needed by localhost PostgreSQL to allow schema_owner to create and upgrade extensions.
    --       We will revoke this privilege before exiting.
    --       This statement will fail on RDS.
    ALTER USER :schema_owner SUPERUSER;
\else
    -- NOTE: Needed by AWS RDS to allow schema_owner to create and upgrade extensions.
    --       This statement will fail on localhost PostgreSQL.
    GRANT rds_superuser TO :schema_owner;
\endif

/* NOTE: With AWS RDS, the rds_superuser role granted to the master user (postgres) requires it to be
         a memeber of the role (user) that will own the database in order to create the database on its behalf.
         We will revoke this privilege before exiting. */
GRANT :schema_owner TO :aws_rds_superuser;


\du+


/* Create Secure User (pega_app_secure) */
CREATE USER :app_sec_user WITH LOGIN ENCRYPTED PASSWORD :'app_sec_pwd';

GRANT :app_sec_role TO :app_sec_user;


/* Create Read Only User (pega_app_reader) */
CREATE USER :app_reader_user WITH LOGIN ENCRYPTED PASSWORD :'app_reader_pwd';

GRANT :app_reader_role TO :app_reader_user;


/* Create Secure User (wc_app_secure) */
CREATE USER :app_sec_user WITH
    LOGIN
    ENCRYPTED PASSWORD :'app_sec_pwd';

GRANT :app_sec_role TO :app_sec_user;


/* Create Read Only User (wc_app_reader) */
CREATE USER :app_reader_user WITH
    LOGIN
    ENCRYPTED PASSWORD :'app_reader_pwd';

GRANT :app_reader_role TO :app_reader_user;


\du+


-- ===========================================
-- postgres: Create Database (wc_dev_db, wc_prod_db)
-- ===========================================
/* As superuser connected to postgres DB, create Warped Citadel Database and assign owership to schema owner */
CREATE DATABASE :dbname WITH
    OWNER :schema_owner
    ENCODING 'UTF8'
    LC_COLLATE='en_US.UTF-8'
    LC_CTYPE='en_US.UTF-8'
    TEMPLATE=template0;

COMMENT ON DATABASE :dbname IS 'Warped Citadel database';


\l+


-- ===========================================
-- As superuser, switch to the new Database
-- ===========================================
\c :dbname
\conninfo


-- ===========================================
-- Make database owner the owner of the Public Schema in the Warped Citadel Database */
-- ===========================================
ALTER SCHEMA public OWNER TO :schema_owner;


-- ===========================================
-- Connect as database owner
-- ===========================================
/* As Database Owner User, connect to Warped Citadel Database and create new Schema */
\c :dbname :schema_owner
\conninfo


-- ===========================================
-- drop schema public from Warped Citadel Database
-- ===========================================
DROP SCHEMA IF EXISTS public CASCADE;

-- ===========================================
-- create schema wc01
-- ===========================================
CREATE SCHEMA wc01;
COMMENT ON SCHEMA wc01 IS 'Warped Citadel core schema';

REVOKE ALL ON SCHEMA wc01 FROM public;


-- ===========================================
-- Grant Permissions on new Schema to Roles
-- ===========================================
/* Grant permissions to Secure Role (wc01_sec_role) */
GRANT CONNECT ON DATABASE   :dbname TO :app_sec_role;
GRANT TEMPORARY ON DATABASE :dbname TO :app_sec_role;
GRANT USAGE ON SCHEMA wc01          TO :app_sec_role;

/* Grant permissions to Read Only Role (wc01_reader_role) */
GRANT CONNECT ON DATABASE   :dbname TO :app_reader_role;
GRANT USAGE ON SCHEMA wc01          TO :app_reader_role;


-- ===========================================
-- dbo_wc: Revoke Permissions from PUBLIC role
-- ===========================================
/* Ensure users can't connect to the database by default unless permission is explicitly granted */
REVOKE ALL ON DATABASE :dbname FROM PUBLIC;


REVOKE :schema_owner FROM :aws_rds_superuser;

SELECT COUNT(0) = 1 AS localhost WHERE inet_server_addr() = '127.0.0.1' OR inet_server_addr() = '::1'
\gset
\if :localhost
    ALTER USER :schema_owner NOSUPERUSER;
\endif

\du+