#!/bin/bash

. ~/Scripts/'Postgresql scripts'/settings

cd ~
echo "You are in: $(pwd)"
echo '-----------------------------------------'


sudo PGPASSWORD=$passU psql -U $loginU -c "alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;"
echo "Threads Number changed to $ThreadsN"
sudo PGPASSWORD=$passU ${pathPgDump}pg_dump -U $loginU -h $hostname -n $SchemaName -F c $Dbname > $DumpLocation
