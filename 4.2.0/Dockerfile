FROM mjstealey/mariadb-galera:latest
MAINTAINER Michael J. Stealey <michael.j.stealey@gmail.com>

# Explicitly set user/group IDs for irods account
RUN groupadd -r irods --gid=996 \
    && useradd -r -g irods -d /var/lib/irods --uid=996 irods

# iRODS v.4.2.0
RUN yum install -y sudo \
    && sudo rpm --import https://packages.irods.org/irods-signing-key.asc \
    && wget -qO - https://packages.irods.org/renci-irods.yum.repo | \
    sudo tee /etc/yum.repos.d/renci-irods.yum.repo \
    && sed -i 's/repo_gpgcheck=1/repo_gpgcheck=0/g' /etc/yum.repos.d/renci-irods.yum.repo \
    && yum install -y \
    irods-server \
    irods-database-plugin-mysql

# update mysql-connector-odbc
RUN wget https://dev.mysql.com/get/Downloads/Connector-ODBC/5.3/mysql-connector-odbc-5.3.7-1.el7.x86_64.rpm \
    && yum --nogpgcheck localinstall -y mysql-connector-odbc-5.3.7-1.el7.x86_64.rpm

# install lib_mysqludf_preg (should not be necessary for v.4.2.1)
RUN yum install -y git gcc automake mariadb-devel pcre-devel \
    && git clone https://github.com/mysqludf/lib_mysqludf_preg.git

# default iRODS env
ENV IRODS_SERVICE_ACCOUNT_NAME=irods
ENV IRODS_SERVICE_ACCOUNT_GROUP=irods
# 1. provider, 2. consumer
ENV IRODS_SERVER_ROLE=1
# 1. MySQL, 2. MySQL ODBC 5.3 Unicode Driver, 3. MySQL ODBC 5.3 ANSI Driver
ENV ODBC_DRIVER_FOR_MYSQL=2
ENV IRODS_DATABASE_SERVER_HOSTNAME=localhost
ENV IRODS_DATABASE_SERVER_PORT=3306
ENV IRODS_DATABASE_NAME=ICAT
ENV IRODS_DATABASE_USER_NAME=irods
ENV IRODS_DATABASE_PASSWORD=temppassword
ENV IRODS_DATABASE_USER_PASSWORD_SALT=tempsalt
ENV IRODS_ZONE_NAME=tempZone
ENV IRODS_PORT=1247
ENV IRODS_PORT_RANGE_BEGIN=20000
ENV IRODS_PORT_RANGE_END=20199
ENV IRODS_CONTROL_PLANE_PORT=1248
ENV IRODS_SCHEMA_VALIDATION=file:///var/lib/irods/configuration_schemas
ENV IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods
ENV IRODS_SERVER_ZONE_KEY=TEMPORARY_zone_key
ENV IRODS_SERVER_NEGOTIATION_KEY=TEMPORARY_32byte_negotiation_key
ENV IRODS_CONTROL_PLANE_KEY=TEMPORARY__32byte_ctrl_plane_key
ENV IRODS_SERVER_ADMINISTRATOR_PASSWORD=rods
ENV IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault

RUN rm -f /docker-entrypoint.sh
ADD ./docker-entrypoint.sh /docker-entrypoint.sh

VOLUME ["var/lib/mysql", "/var/lib/irods"]

EXPOSE 3306 4567 $IRODS_PORT $IRODS_CONTROL_PLANE_PORT $IRODS_PORT_RANGE_BEGIN-$IRODS_PORT_RANGE_END
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["setup_irods.py"]