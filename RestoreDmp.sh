#!/bin/bash

PathToSettings=$(dirname "$0")
echo "Имя скрипта <$( basename -- "$0"; )>, директория <$PathToSettings>";
cd "$PathToSettings"
if [[ -f settings ]]
then
    . ./settings
    echo "Файл settings загружен"
else
    echo 'Файл settings не найден'
    exit 1
fi

read -p 'Enter the database name: ' NewDb

sudo PGPASSWORD=$passU -u $loginU psql  << XENDX  # по идее нет разницы, где указывать юзера, до или после команды
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
