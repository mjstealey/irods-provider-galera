#!/usr/bin/env bash
set -e

IRODS_CONFIG_FILE=/irods.config
PACKAGE='docker-entrypoint'
INIT=false
JOIN=false
USAGE=false
VERBOSE=false
SQLFILE=''
DUMPDB=false
SETUP_IRODS=false
REJOIN_IRODS=false

_update_uid_gid() {
    # if UID_MYSQL = UID_IRODS, exit with error message
    if [[ ${UID_MYSQL} = ${UID_IRODS} ]]; then
        echo "ERROR: user irods and user mysql cannot have same UID!!!"
        exit 1;
    else
    # if UID_MYSQL != UID_IRODS, reassign individual UIDs
        if [[ ${UID_IRODS} = 997 ]]; then
            gosu root usermod -u 1997 irods
        fi
        gosu root usermod -u ${UID_MYSQL} mysql
        gosu root usermod -u ${UID_IRODS} irods
    fi
    # if GID_MYSQL = GID_IRODS, reset GID_MYSQL=GID_IRODS-1 and use GID_IRODS group permissions
    if [[ ${GID_MYSQL} = ${GID_IRODS} ]]; then
        gosu root groupmod -g ${GID_IRODS} irods
        gosu root usermod -a -G ${GID_IRODS} mysql
        gosu root chown -R mysql:irods /var/lib/mysql
        gosu root chown -R irods:irods /var/lib/irods
        gosu root chown -R irods:irods /etc/irods
    else
    # if GID_MYSQL != GID_IRODS, reassign individual GIDs
        if [[ ${GID_IRODS} = 997 ]]; then
            gosu root groupmod -g 1997 irods
        fi
        gosu root groupmod -g ${GID_MYSQL} mysql
        gosu root groupmod -g ${GID_IRODS} irods
        gosu root chown -R mysql:mysql /var/lib/mysql
        gosu root chown -R irods:irods /var/lib/irods
        gosu root chown -R irods:irods /etc/irods
     fi
}

_mysql_tgz() {
    if [ ! "$(ls -A /var/lib/mysql)" ]; then
        gosu root cp /mysql.tar.gz /var/lib/mysql/mysql.tar.gz
        cd /var/lib/mysql/
        if $VERBOSE; then
            echo "!!! populating /var/lib/mysql with initial contents !!!"
            gosu root tar -zxvf mysql.tar.gz
        else
            gosu root tar -zxf mysql.tar.gz
        fi
        cd -
        gosu root rm -f /var/lib/mysql/mysql.tar.gz
    fi
}

_irods_tgz() {
    if [ ! "$(ls -A /var/lib/irods)" ]; then
        gosu root cp /irods.tar.gz /var/lib/irods/irods.tar.gz
        cd /var/lib/irods/
        if $VERBOSE; then
            echo "!!! populating /var/lib/irods with initial contents !!!"
            gosu root tar -zxvf irods.tar.gz
        else
            gosu root tar -zxf irods.tar.gz
        fi
        cd -
        gosu root rm -f /var/lib/irods/irods.tar.gz
    fi
}

_server_cnf() {
    SERVER_CNF=/etc/my.cnf.d/server.cnf
    echo "set ${SERVER_CNF}"
    > ${SERVER_CNF}
    echo "[galera]" >> ${SERVER_CNF}
    echo "# Mandatory settings" >> ${SERVER_CNF}
    echo "wsrep_on=${WSREP_ON}" >> ${SERVER_CNF}
    echo "wsrep_provider=${WSREP_PROVIDER}" >> ${SERVER_CNF}
    if [[ ! -z "${WSREP_PROVIDER_OPTIONS// }" ]]; then
        echo "wsrep_provider_options"=${WSREP_PROVIDER_OPTIONS} >> ${SERVER_CNF}
    fi
    echo "wsrep_cluster_address=${WSREP_CLUSTER_ADDRESS}" >> ${SERVER_CNF}
    echo "wsrep_cluster_name=${WSREP_CLUSTER_NAME}" >> ${SERVER_CNF}
    echo "wsrep_node_address=${WSREP_NODE_ADDRESS}" >> ${SERVER_CNF}
    echo "wsrep_node_name=${WSREP_NODE_NAME}" >> ${SERVER_CNF}
    echo "wsrep_sst_method=${WSREP_SST_METHOD}" >> ${SERVER_CNF}
    echo "" >> ${SERVER_CNF}
    echo "binlog_format=${BINLOG_FORMAT}" >> ${SERVER_CNF}
    echo "default_storage_engine=${DEFAULT_STORAGE_ENGINE}" >> ${SERVER_CNF}
    echo "innodb_autoinc_lock_mode=${INNODB_AUTOINC_LOCK_MODE}" >> ${SERVER_CNF}
    echo "bind-address=${BIND_ADDRESS}" >> ${SERVER_CNF}
}

_mysql_secure_installation() {
    MSI_RESPONSE=/.msi_response
    echo "exec mysql_secure_installation"
    > ${MSI_RESPONSE}
    echo "" >> ${MSI_RESPONSE}
    echo "y" >> ${MSI_RESPONSE}
    echo "${MYSQL_ROOT_PASSWORD}" >> ${MSI_RESPONSE}
    echo "${MYSQL_ROOT_PASSWORD}" >> ${MSI_RESPONSE}
    echo "y" >> ${MSI_RESPONSE}
    echo "y" >> ${MSI_RESPONSE}
    echo "y" >> ${MSI_RESPONSE}
    echo "y" >> ${MSI_RESPONSE}
    mysql_secure_installation < ${MSI_RESPONSE}
}

_generate_config() {
    > ${IRODS_CONFIG_FILE}
    echo "${IRODS_SERVICE_ACCOUNT_NAME}" >> ${IRODS_CONFIG_FILE}
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
    INITIALIZE_SQL=/initialize.sql
    > ${INITIALIZE_SQL}
    echo "CREATE DATABASE ${IRODS_DATABASE_NAME} character set latin1 collate latin1_general_cs;" >> ${INITIALIZE_SQL}
    echo "CREATE USER '${IRODS_DATABASE_USER_NAME}'@'${IRODS_DATABASE_SERVER_HOSTNAME}' IDENTIFIED BY '${IRODS_DATABASE_PASSWORD}';" >> ${INITIALIZE_SQL}
    echo "GRANT ALL ON ${IRODS_DATABASE_NAME}.* to '${IRODS_DATABASE_USER_NAME}'@'${IRODS_DATABASE_SERVER_HOSTNAME}';" >> ${INITIALIZE_SQL}
    echo "SHOW GRANTS FOR '${IRODS_DATABASE_USER_NAME}'@'${IRODS_DATABASE_SERVER_HOSTNAME}';" >> ${INITIALIZE_SQL}
}

_my_cnf() {
    MY_CNF=/etc/my.cnf
    > ${MY_CNF}
    echo "#" >> ${MY_CNF}
    echo "# This group is read both both by the client and the server" >> ${MY_CNF}
    echo "# use it for options that affect everything" >> ${MY_CNF}
    echo "#" >> ${MY_CNF}
    echo "[client-server]" >> ${MY_CNF}
    echo "" >> ${MY_CNF}
    echo "#" >> ${MY_CNF}
    echo "# include all files from the config directory" >> ${MY_CNF}
    echo "#" >> ${MY_CNF}
    echo "!includedir /etc/my.cnf.d" >> ${MY_CNF}
    echo "[mysqld]" >> ${MY_CNF}
    echo "log_bin_trust_function_creators=1" >> ${MY_CNF}
}

# lib_mysqludf_preg should no longer be needed after v.4.2.1
_lib_mysqludf_preg() {
    cd /lib_mysqludf_preg/
    touch configure.ac aclocal.m4 configure Makefile.am Makefile.in
    ./configure
    make
    sudo make install
    if $SETUP_IRODS; then
        gosu root mysql -uroot -p${MYSQL_ROOT_PASSWORD} < /lib_mysqludf_preg/installdb.sql
    fi
    cd -
}

_usage() {
    echo "iRODS Provider - Galera Cluster"
    echo " "
    echo "${PACKAGE} [-hijvd] [-f filename.sql] [arguments]"
    echo " "
    echo "options:"
    echo "-h                    show brief help"
    echo "-i                    initialize iRODS Galera cluster"
    echo "-j                    join existing iRODS Galera cluster"
    echo "-v                    verbose output"
    echo "-d                    dump database as db.sql to volume mounted as /LOCAL/PATH:/init"
    echo "-f filename.sql       provide SQL script to initialize database from volume mounted as /LOCAL/PATH:/init"
    echo ""
    echo "Example:"
    echo "  $ docker run --rm mjstealey/irods-provider-galera:4.2.0 -h               # show help"
    echo "  $ docker run -d mjstealey/irods-provider-galera:4.2.0 -iv setup_irods.py # init with default settings"
    echo ""
    exit 0
}

while getopts 'hijvdf:q' opt; do
  case "${opt}" in
    h) USAGE=true ;;
    i) INIT=true ;;
    j) JOIN=true ;;
    f) SQLFILE="${OPTARG}" ;;
    d) DUMPDB=true ;;
    v) VERBOSE=true ;;
    ?) echo "Invalid option provided" && USAGE=true ;;
  esac
done

for var in "$@"
do
    if [[ "${var}" = 'setup_irods.py' ]]; then
        SETUP_IRODS=true
    fi
    if [[ "${var}" = 'rejoin_irods' ]]; then
        REJOIN_IRODS=true
    fi
done

if $SETUP_IRODS; then
    if $USAGE; then
        _usage
    fi
    _mysql_tgz
    _irods_tgz
    _update_uid_gid
    gosu root /etc/init.d/mysql start
    _mysql_secure_installation
    _generate_config
    if [[ -e /init/${SQLFILE} && "${SQLFILE}" != '' ]]; then
        gosu root mysql -uroot -p${MYSQL_ROOT_PASSWORD} < /init/${SQLFILE}
    else
        _initialize_sql
        gosu root mysql -uroot -p${MYSQL_ROOT_PASSWORD} < /initialize.sql
    fi
    _lib_mysqludf_preg
    _my_cnf
    gosu root ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
    gosu root /etc/init.d/mysql stop
    gosu root /etc/init.d/mysql start
    gosu root python /var/lib/irods/scripts/setup_irods.py < ${IRODS_CONFIG_FILE}
    if $DUMPDB; then
        gosu root mysqldump -uroot -p${MYSQL_ROOT_PASSWORD} --all-databases > /init/db.sql
        gosu root chown -R irods:irods /init
    fi
    gosu root /etc/init.d/mysql stop
    _server_cnf
    if $VERBOSE; then
        echo "$ cat /etc/my.cnf.d/server.cnf"
        cat /etc/my.cnf.d/server.cnf
    fi
    if $INIT; then
        gosu root /etc/init.d/mysql start --wsrep-new-cluster
    fi
    if $JOIN; then
        gosu root /etc/init.d/mysql start
    fi
    if $VERBOSE; then
        echo "[MySQL]> SHOW VARIABLES LIKE 'wsrep%';"
        gosu root mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "SHOW VARIABLES LIKE 'wsrep%';" \
        | fold -w 80 -s
        echo "$ ss -lntu"
        gosu root ss -lntu
    fi
    _update_uid_gid
    gosu root tail -f /dev/null
elif $REJOIN_IRODS; then
    _update_uid_gid
    _server_cnf
    _my_cnf
    _lib_mysqludf_preg
    gosu root ln -s /var/lib/mysql/mysql.sock /tmp/mysql.sock
    if $INIT; then
        gosu root /etc/init.d/mysql start --wsrep-new-cluster
    fi
    if $JOIN; then
        gosu root /etc/init.d/mysql start
    fi
    gosu root /etc/init.d/irods start
    _update_uid_gid
    gosu root tail -f /dev/null
else
    if $USAGE; then
        _usage
    fi
    _update_uid_gid
    exec "$@"
fi
