#!/bin/bash

. ~/Scripts/'Postgresql scripts'/settings

cd ~
echo "You are in: $(pwd)"
echo '-----------------------------------------'


read -p 'Enter the database name: ' NewDb


#createdb -U $loginU $NewDb
sudo PGPASSWORD=$passU -u $loginU psql  << XENDX 
drop database if exists $NewDb;
create database $NewDb;
alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;
XENDX

SchemaParms=""
for item in ${SchemaName[*]}
do
    SchemaParms+="$item "
    if [[ $item != '-n' ]]
    then
      sudo PGPASSWORD=$passU -u $loginU  psql -d $NewDb -c "drop schema if exists $item; create schema $item;"
    fi

    printf "   %s\n" $item
done
echo $SchemaParms

echo "Threads Number changed to $ThreadsN"

sudo PGPASSWORD=$passU ${pathPgRst}pg_restore -d $NewDb  -U $loginU -h $hostname  $SchemaParms  $DumpLocation
