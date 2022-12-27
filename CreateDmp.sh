#!/bin/bash
#To-do:на некоторых соединениях не все параметры прописаны(например, хост не указан) 

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

SchemaParms=""

for item in ${SchemaName[*]}
do
    SchemaParms+="${item}"" "
    #printf "   %s" $item
done

sudo PGPASSWORD=$passU psql -U $loginU -c "alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;"
echo "Threads Number changed to $ThreadsN"
echo $Dbname
sudo PGPASSWORD=$passU ${pathPgDump}pg_dump -U $loginU -h $hostname ${SchemaParms} -F c $Dbname > $DumpLocation
