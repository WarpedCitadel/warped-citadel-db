/****************************************************************************************
* Written for PostgreSQL 14.x, 15.x, 16.x
*
* Description:
*    This script is used in conjunction with created_database.sql and rip_database.sql.
*
* Usage:
*    Edit the parameter values below for the target database.
*
*    Rename the file replacing "target-db" with the target database name.
*        e.g. wc_dev_parameters.sql
*
*    When executing created_database.sql or rip_database.sql with the psql client, pass
*    in a variable named "vdbname" with the value of your target database name used when
*    renaming this file. The created_database.sql and rip_database.sql scripts will then dynamically
*    execute the correct parameters file.
*
*    Ex: psql --host=localhost --username=postgres --dbname=postgres --echo-all -f create_database.sql -v vdbname='wc_dev'
*
*
*
***************************************************************************************/

-- Warped Citadel Database
\set dbname                    'wc_dev'


-- Schema Owner User
\set schema_owner              'dbo_wc'
\set schema_owner_pwd          'changme'


-- Secure Users
\set app_reader_user           'wc_app_reader'
\set app_reader_pwd            'changme'

\set app_sec_user              'wc_app_secure'
\set app_sec_pwd               'changme'


-- Secure Roles (DO NOT CHANGE!)
\set app_reader_role           'wc_read_only_role'
\set app_sec_role              'wc_secure_role'
\set schema_owner_role         'wc_dbo_role'