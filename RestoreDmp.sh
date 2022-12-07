#!/bin/bash

. ~/Scripts/'Postgresql scripts'/settings

cd ~
echo "You are in: $(pwd)"
echo '-----------------------------------------'

read -p 'Enter the database name: ' NewDb

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

echo "Threads Number changed to $ThreadsN"

sudo PGPASSWORD=$passU ${pathPgRst}pg_restore -d $NewDb  -U $loginU -h $hostname -n $SchemaName  $DumpLocation
