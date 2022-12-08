#!/bin/bash

pathPgDump=/usr/bin/
pathPgRst=/usr/bin/
Dbname=shaitan
hostname=localhost
loginU=shaitan
passU=qwerty
#SchemaName="-n public -n myschema"
SchemaName=("-n" "myschema")
ThreadsN=4
DumpLocation=./godno.dmp
