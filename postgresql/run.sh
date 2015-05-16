#!/bin/bash
#set -e

POSTGRES_USER=${POSTGRES_USER:-"dbuser"}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-"password"}
POSTGRES_DB=${POSTGRES_DB:-"database"}
POSTGRES_ARGS="-D $PGDATA --config-file=/etc/pgsql/postgresql.conf"

if [ ! -d $PGDATA ]; then
    mkdir -p $PGDATA
    chown -R postgres $PGDATA
    su - postgres -c "$PG_HOME/bin/initdb -D $PGDATA -E 'UTF-8'"
fi

echo "CREATE DATABASE ${POSTGRES_DB}" | su - postgres -c "$PG_HOME/bin/postgres --single $POSTGRES_ARGS > /dev/null"
echo "CREATE ROLE ${POSTGRES_USER} LOGIN PASSWORD '${POSTGRES_PASSWORD}'" | su - postgres -c "$PG_HOME/bin/postgres --single $POSTGRES_ARGS > /dev/null"
echo "GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER}" | su - postgres -c "$PG_HOME/bin/postgres --single $POSTGRES_ARGS > /dev/null"
su - postgres -c "$PG_HOME/bin/postgres $POSTGRES_ARGS"
