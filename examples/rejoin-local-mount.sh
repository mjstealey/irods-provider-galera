#!/usr/bin/env bash

docker stop galera && docker rm -fv galera

LOCAL_MNT=/home/${USER}/galera
VAR_MYSQL=${LOCAL_MNT}/var_mysql
VAR_IRODS=${LOCAL_MNT}/var_irods
ETC_IRODS=${LOCAL_MNT}/etc_irods
SQL_INIT=${LOCAL_MNT}/sql_init

docker run -d --name galera -h irods-galera-node-1 \
    -v ${VAR_MYSQL}:/var/lib/mysql \
    -v ${VAR_IRODS}:/var/lib/irods \
    -v ${ETC_IRODS}:/etc/irods \
    -v ${SQL_INIT}:/init \
    -p 1247-1248:1247-1248 \
    -p 3306:3306 \
    -p 4444:4444 \
    -p 4567-4568:4567-4568 \
    -p 20000-20199:20000-20199 \
    mjstealey/irods-provider-galera:4.2.0 -iv rejoin_irods

exit 0;
