#!/bin/bash

if [ -n "$MYSQL_PORT_3306_TCP" ]; then
	if [ -z "$MYSQL_HOST" ]; then
		MYSQL_HOST='mysql'
	else
		echo >&2 'warning: both MYSQL_HOST and MYSQL_PORT_3306_TCP found'
		echo >&2 "  Connecting to MYSQL_HOST ($MYSQL_HOST)"
		echo >&2 '  instead of the linked mysql container'
	fi
fi

if [ -z "$MYSQL_HOST" ]; then
	echo >&2 'error: missing MYSQL_HOST and MYSQL_PORT_3306_TCP environment variables'
	echo >&2 '  Did you forget to --link some_mysql_container:mysql or set an external db'
	echo >&2 '  with -e MYSQL_HOST=hostname:port?'
	exit 1
fi

# if we're linked to MySQL, and we're using the root user, and our linked
# container has a default "root" password set up and passed through... :)
: ${MYSQL_USER:=root}
if [ "$MYSQL_USER" = 'root' ]; then
	: ${MYSQL_PASS:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
fi
: ${MYSQL_DB:=powerdns}

if [ -z "$MYSQL_PASS" ]; then
	echo >&2 'error: missing required MYSQL_PASS environment variable'
	echo >&2 '  Did you forget to -e MYSQL_PASS=... ?'
	echo >&2
	echo >&2 '  (Also of interest might be MYSQL_USER and MYSQL_DB.)'
	exit 1
fi

host=${MYSQL_HOST}
user=${MYSQL_USER}
pass=${MYSQL_PASS}
db=${MYSQL_DB}

exec pdns_server --launch=gmysql --daemon=no --gmysql-host=$host --gmysql-user=$user --gmysql-password=$pass --gmysql-dbname=$db
