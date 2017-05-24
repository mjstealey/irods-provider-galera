#!/usr/bin/env bash

docker stop galera && docker rm -fv galera

LOCAL_MNT=/home/${USER}/galera
VAR_MYSQL=${LOCAL_MNT}/var_mysql
VAR_IRODS=${LOCAL_MNT}/var_irods
ETC_IRODS=${LOCAL_MNT}/etc_irods
SQL_INIT=${LOCAL_MNT}/sql_init

_initialize_sql() {
    INITIALIZE_SQL=${SQL_INIT}/myinit.sql
    > ${INITIALIZE_SQL}
    echo "CREATE DATABASE ICAT character set latin1 collate latin1_general_cs;" >> ${INITIALIZE_SQL}
    echo "CREATE USER 'irods'@'localhost' IDENTIFIED BY 'temppassword';" >> ${INITIALIZE_SQL}
    echo "GRANT ALL ON ICAT.* to 'irods'@'localhost';" >> ${INITIALIZE_SQL}
    echo "SHOW GRANTS FOR 'irods'@'localhost';" >> ${INITIALIZE_SQL}
}

if [[ -d ${LOCAL_MNT} ]]; then
    sudo rm -rf ${LOCAL_MNT}
fi

mkdir -p ${VAR_MYSQL}
mkdir -p ${VAR_IRODS}
mkdir -p ${ETC_IRODS}
mkdir -p ${SQL_INIT}

_initialize_sql

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
    irods-galera -ivdf myinit.sql setup_irods.py

exit 0;