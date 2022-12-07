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


read -p 'Enter the database name: ' NewDb
#sudo PGPASSWORD=$passU psql -U $loginU -c "alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;"

#createdb -U $loginU $NewDb

# Тут в принципе можно от админа делать -u postgres, потому что если восстанавливать в БД по умолчанию (типа юзер shaitan бд shaitan) будет ошибка
sudo PGPASSWORD=$passU -u $loginU psql  << XENDX  # по идее нет разницы, где указывать юзера, до или после команды
drop database if exists $NewDb;
create database $NewDb;
\c $NewDb;
drop schema if exists public;
drop schema if exists $SchemaName;
create schema public;
create schema $SchemaName;
alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;
XENDX
#alter user $loginU set max_parallel_workers_per_gather=$ThreadsN;

echo "Threads Number changed to $ThreadsN"


#psql -c 'SHOW max_parallel_workers_per_gather;'

#dropdb -U shaitan tmp3 && \
#createdb -T template0 $NewDb     --create --dbname=$NewDb
sudo PGPASSWORD=$passU ${pathPgRst}pg_restore -d $NewDb  -U $loginU -h $hostname -n $SchemaName  $DumpLocation
