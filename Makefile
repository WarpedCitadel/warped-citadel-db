export JAVA_OPTS=-Dfile.encoding=UTF-8


wc_base_dir := database/
wc_base_deploy := database/schema_create

wc_rel_dirs := $(sort $(dir $(wildcard $(wc_base_dir)/*/)))

pgdevhost	:=	localhost
pgdevport	:=	7953

LOCAL_PG_IP		?=	localhost
LOCAL_PG_PORT	?=	5432
LOCAL_PG_PSQL	?=	psql.exe


readme rip_create_local deploy_local: localpgip    :=$(LOCAL_PG_IP)
readme rip_create_local deploy_local: localpgport  :=$(LOCAL_PG_PORT)
database_rip rip_create_local database_rip_dev rip_create_dev rip_qa: psql :=$(LOCAL_PG_PSQL)


.PHONY: readme database_rip rip_local rip_create_local rip_dev rip_qa database_deploy deploy_local database_rip_dev deploy_dev rip_create_dev deploy_qa

readme:
	@echo \
"\n**** STOP! You must run make with a specific target! ****\n\
\n\
To drop and recreate the Warped Citadel database, use one of these targets.\n\
(You will be prompted for the postgres, dbo_wc user passwords.\n\
Ensure you are using the passwords you assigned in your schema_sec/<db name>_parameters.sql files).\n\
you can configure a .pgpass file to avoid these prompts.)\n\
\n\
	rip_create_local	Drop and recreate LOCAL databases at $(localpgip):$(localpgport).\n\
				if ripping local, declare environment variables LOCAL_PG_IP and LOCAL_PG_PORT\n\
				if your PostgreSQL database does not live at default host localhost, port 5432.\n\
\n\
	rip_create_dev		Drop and recreate Dev database in US-EAST-2\n\
\n\
	rip_qa			Drop and recreate QA database in US-EAST-2\n\
\n\
\n\n\
To create a schema objects for Warped Citadel database, use on of these targets.\n\
(Database user passwords are dynamically pulled from your schema_sec/<db name>_parameters.sql files.)\n\
\n\
	deploy_local		Create schema objects in your LOCAL database at $(localpgip):$(localpgport).\n\
				if deploying local, declare environment variables LOCAL_PG_IP and localpgport\n\
				if your PostgreSQL database does not live at the default host local host, port 5432.\n\
\n\
	deploy_dev		Create schema objects in Dev database in US-EAST-2.\n\
\n\
	deploy_qa		Create schema objects in the QA database in US-EAST-2.\n"




# ----- Database RIP / Create Worker ----
database_rip:
	@echo; echo DIRECTORY: $(pgdir); echo
	cd $(pgdir); \
	$(psql) -h $(pghost) -p $(pgport) -U postgres -d postgres -a -f $(pgfile) -v vdbname='$(pgdbname)'


database_rip_dev:
	@echo; echo DIRECTORY: $(pgdir); echo
	cd $(pgdir); \
	$(psql) -h $(pghost) -p $(pgdevport) -U peterabo -d postgres -a -f $(pgfile) -v vdbname='$(pgdbname)'


# ----- Database RIP / Create ----
rip_create_local:
	@echo Using psql version; $(psql) --version
	@echo Dropping and recreating Local database at $(localpgip):$(localpgport). Are you sure? [Y/n]
	@read line; if [ ! $$line = "Y" ] && [ ! $$line = "y" ]; then echo Aborting...; exit 1; fi


	#Warped Citadel Local Database RIP
	@make pgdir=$(wc_base_dir)db_rip/ pghost=$(localpgip) pgport=$(localpgport) pgfile=rip_database.sql pgdbname=wc_local database_rip


	#Warped Citadel Local Database create
	@make pgdir=$(wc_base_dir)db_create/ pghost=$(localpgip) pgport=$(localpgport) pgfile=create_database.sql pgdbname=wc_local database_rip


rip_create_dev:
	@echo Using psql version:; $(psql) --version
	@echo Dropping and recreating DEV database in US-EAST-2. Are you sure? [Y/n]
	@read line; if [ ! $$line = "Y" ] && [ ! $$line = "y" ]; then echo ABORTING...; exit 1; fi


	# Warped Citadel RIP
	@make pgdir=$(wc_base_dir)db_rip/ pghost=$(pgdevhost) pgport=$(pgdevport) pgfile=rip_database.sql pgdbname=wc_dev database_rip_dev


	# Warped Citadel Create
	@make pgdir=$(wc_base_dir)db_create/ pghost=$(pgdevhost) pgport=$(pgdevport) pgfile=create_database.sql pgdbname=wc_dev database_rip_dev


# ---- Liquibase Update
liquibase_update:
	cd $(pgdir); \
	yes "" | liquibase --username=$(pguser) --password=$(pgpwd) --url=jdbc:postgresql://$(pgdomain):$(pgport)/$(pgdbname) update


# ---- Database Deploy Worker
database_deploy:
	@echo; echo DIRECTORY: $(pgdir); echo
	@make pgdir=$(pgdir) pguser=$(pguser) pgdomain=$(pgdomain) pgport=$(pgport) pgdbname=$(pgdbname) liquibase_update


# Database Deploy
deploy_local:
	@echo Deploying LOCAL database at $(localpgip):$(localpgport). Are you sure? [Y/n]
	@read line; if [ ! $$line = "Y" ] && [ ! $$line = "y" ]; then echo Aborting...; exit 1; fi

	$(eval wcpwd := $(shell grep -iw schema_owner_pwd $(wc_base_dir)schema_sec/wc_local_parameters.sql | grep -iEo "'([[:alnum:]]*)'" | grep -iEo "([[:alnum:]]*)"))

	@make pgdir=$(wc_base_deploy) pguser=dbo_wc pgpwd=$(wcpwd) pgdomain=$(localpgip) pgport=$(localpgport) pgdbname=wc_local database_deploy


deploy_dev:
	@echo Deploying DEV database at US-EAST-2. Are you sure? [Y/n]
	@read line; if [ ! $$line = "Y" ] && [ ! $$line = "y" ]; then echo Aborting...; exit 1; fi

	$(eval wcpwd := $(shell grep -iw schema_owner_pwd $(wc_base_dir)schema_sec/wc_dev_parameters.sql | grep -iEo "'([[:alnum:]]*)'" | grep -iEo "([[:alnum:]]*)"))

	@make pgdir=$(wc_base_deploy) pguser=dbo_wc pgpwd=$(wcpwd) pgdomain=$(localpgip) pgport=$(pgdevport) pgdbname=wc_dev database_deploy