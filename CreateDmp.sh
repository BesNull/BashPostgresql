#!/bin/bash
#To-do:на некоторых соединениях не все параметры прописаны(например, хост не указан) 

. ~/Scripts/'Postgresql scripts'/settings

cd ~
echo "You are in: $(pwd)"
echo '-----------------------------------------'

SchemaParms=""
space=" "
for item in ${SchemaName[*]}
do
    SchemaParms+="${item}"" "
    #printf "   %s" $item
done

echo
echo ${SchemaParms}  #показывает немного коряво, если делать эхо без кавычек, но при полдстановке все дампит
echo

sudo PGPASSWORD=$passU psql -U $loginU -c "alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;"
echo "Threads Number changed to $ThreadsN"
echo $Dbname
sudo PGPASSWORD=$passU ${pathPgDump}pg_dump -U $loginU -h $hostname ${SchemaParms} -F c $Dbname > $DumpLocation
