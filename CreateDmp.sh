#!/bin/bash
#sudo  -u postgres
#~/Scripts/'Postgresql scripts'/settings

. ~/Scripts/'Postgresql scripts'/settings

#echo $testvar

#path = $(pwd)
cd ~
echo "You are in: $(pwd)"
echo '-----------------------------------------'

#echo "Enter the path:"
#read pathDb
#echo
#echo "Enter the DB name:"
#read dbname

#Минимальное ограничение задает параметр max_parallel_workers_per_gather. Потом исполнитель запросов берет рабочие процессы из пула, ограниченного параметром max_parallel_workers size.
#Последнее ограничение — это max_worker_processes, то есть общее число фоновых процессов.


#create schema myschema;
#alter system set max_parallel_workers_per_gather=4;
#alter table if exists  users set schema myschema;
#"alter system set max_parallel_workers_per_gather=$ThreadsN;"
sudo PGPASSWORD=$passU psql -U $loginU -c "alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;"
echo "Threads Number changed to $ThreadsN"
echo $Dbname
sudo PGPASSWORD=$passU ${pathPgDump}pg_dump -U $loginU -h $hostname -n $SchemaName -F c $Dbname > $DumpLocation
