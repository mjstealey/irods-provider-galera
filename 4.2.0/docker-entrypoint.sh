#!/usr/bin/env bash
set -e

IRODS_CONFIG_FILE=/irods.config

_server_cnf() {
    echo "set /etc/my.cnf.d/server.cnf"
    > /etc/my.cnf.d/server.cnf
    echo "[galera]" >> /etc/my.cnf.d/server.cnf
    echo "# Mandatory settings" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_on=${WSREP_ON}" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_provider=${WSREP_PROVIDER}" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_cluster_address=${WSREP_CLUSTER_ADDRESS}" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_cluster_name=${WSREP_CLUSTER_NAME}" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_node_address=${WSREP_NODE_ADDRESS}" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_node_name=${WSREP_NODE_NAME}" >> /etc/my.cnf.d/server.cnf
    echo "wsrep_sst_method=${WSREP_SST_METHOD}" >> /etc/my.cnf.d/server.cnf
    echo "" >> /etc/my.cnf.d/server.cnf
    echo "binlog_format=${BINLOG_FORMAT}" >> /etc/my.cnf.d/server.cnf
    echo "default_storage_engine=${DEFAULT_STORAGE_ENGINE}" >> /etc/my.cnf.d/server.cnf
    echo "innodb_autoinc_lock_mode=${INNODB_AUTOINC_LOCK_MODE}" >> /etc/my.cnf.d/server.cnf
    echo "bind-address=${BIND_ADDRESS}" >> /etc/my.cnf.d/server.cnf
}

_mysql_secure_installation() {
    echo "exec mysql_secure_installation"
    > /.msi_response
    echo "" >> /.msi_response
    echo "y" >> /.msi_response
    echo "${MYSQL_ROOT_PASSWORD}" >> /.msi_response
    echo "${MYSQL_ROOT_PASSWORD}" >> /.msi_response
    echo "y" >> /.msi_response
    echo "y" >> /.msi_response
    echo "y" >> /.msi_response
    echo "y" >> /.msi_response
    mysql_secure_installation < /.msi_response
}

_generate_config() {
    DATABASE_HOSTNAME_OR_IP=$(/sbin/ip -f inet -4 -o addr | grep eth | cut -d '/' -f 1 | rev | cut -d ' ' -f 1 | rev)
    echo "${IRODS_SERVICE_ACCOUNT_NAME}" > ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVICE_ACCOUNT_GROUP}" >> ${IRODS_CONFIG_FILE}
    # 1. provider, 2. consumer
    echo "${IRODS_SERVER_ROLE}" >> ${IRODS_CONFIG_FILE}
    # 1. MySQL, 2. MySQL ODBC 5.3 Unicode Driver, 3. MySQL ODBC 5.3 ANSI Driver
    echo "${ODBC_DRIVER_FOR_MYSQL}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_SERVER_HOSTNAME}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_SERVER_PORT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_USER_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "yes" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_PASSWORD}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_DATABASE_USER_PASSWORD_SALT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_ZONE_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_PORT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_PORT_RANGE_BEGIN}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_PORT_RANGE_END}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_CONTROL_PLANE_PORT}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SCHEMA_VALIDATION}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ADMINISTRATOR_USER_NAME}" >> ${IRODS_CONFIG_FILE}
    echo "yes" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ZONE_KEY}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_NEGOTIATION_KEY}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_CONTROL_PLANE_KEY}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVER_ADMINISTRATOR_PASSWORD}" >> ${IRODS_CONFIG_FILE}
    echo "${IRODS_VAULT_DIRECTORY}" >> ${IRODS_CONFIG_FILE}
}

_initialize_sql() {
    > /initialize.sql
    echo "CREATE DATABASE ${IRODS_DATABASE_NAME} character set latin1 collate latin1_general_cs;" >> /initialize.sql
    echo "CREATE USER '${IRODS_DATABASE_USER_NAME}'@'${IRODS_DATABASE_SERVER_HOSTNAME}' IDENTIFIED BY '${IRODS_DATABASE_PASSWORD}';" >> /initialize.sql
    echo "GRANT ALL ON ${IRODS_DATABASE_NAME}.* to '${IRODS_DATABASE_USER_NAME}'@'${IRODS_DATABASE_SERVER_HOSTNAME}';" >> /initialize.sql
    echo "SHOW GRANTS FOR '${IRODS_DATABASE_USER_NAME}'@'${IRODS_DATABASE_SERVER_HOSTNAME}';" >> /initialize.sql
}

_my_cnf() {
    echo "[mysqld]" >> /etc/my.cnf
    echo "log_bin_trust_function_creators=1" >> /etc/my.cnf
}

# lib_mysqludf_preg should no longer be needed after v.4.2.1
_lib_mysqludf_preg() {
    cd /lib_mysqludf_preg/
    touch configure.ac aclocal.m4 configure Makefile.am Makefile.in
    ./configure
    make
    sudo make install
    gosu root mysql --user=root --password=${MYSQL_ROOT_PASSWORD} < /lib_mysqludf_preg/installdb.sql
    cd -
}


if [[ ${1} = 'setup_irods.py' ]]; then
    gosu root chown -R irods:irods ${IRODS_VAULT_DIRECTORY}
    gosu root /etc/init.d/mysql start
    _mysql_secure_installation
    if [[ ${2} = '--init' ]]; then
        # mysql --user=user_name --password=your_password db_name
        _generate_config
        _initialize_sql
        gosu root mysql --user=root --password=${MYSQL_ROOT_PASSWORD} < /initialize.sql
        _lib_mysqludf_preg
        _my_cnf
        gosu root ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
        gosu root /etc/init.d/mysql stop
        gosu root /etc/init.d/mysql start
        gosu root python /var/lib/irods/scripts/setup_irods.py < ${IRODS_CONFIG_FILE}
        gosu root mysqldump --user=root --password=${MYSQL_ROOT_PASSWORD} --all-databases > /init/db.sql
    fi
    gosu root /etc/init.d/mysql stop
    _server_cnf
    cat /etc/my.cnf.d/server.cnf
    gosu root /etc/init.d/mysql start
    gosu root ss -lntu
    gosu root tail -f /dev/null
else
    exec "$@"
fi




