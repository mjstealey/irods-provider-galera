+++
date = "2017-05-28T21:26:16-04:00"
description = "Galera VMs used for testing"
title = "Galera VMs"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "vms"
    parent = "setup"
    weight = 7

+++

Three CentOS Linux release 7.3.1611 (Core) virtual machines (VMs) were stood up to establish an iRODS provider Galera cluster testbed. Each VM is configured with a user account named **galera** which has rights to run [Docker](https://www.docker.com) and not much else.

### galera1.env

```ini
WSREP_ON=ON
WSREP_PROVIDER=/usr/lib64/galera/libgalera_smm.so
WSREP_PROVIDER_OPTIONS='evs.keepalive_period=PT3S;
  evs.suspect_timeout=PT30S;
  evs.inactive_timeout=PT1M;
  evs.install_timeout=PT1M;
  evs.join_retrans_period=PT1.5S'
WSREP_CLUSTER_ADDRESS='gcomm://172.25.8.171,172.25.8.172,172.25.8.173'
WSREP_CLUSTER_NAME='galera'
WSREP_NODE_ADDRESS='172.25.8.171'
WSREP_NODE_NAME='galera-1'
WSREP_SST_METHOD=rsync
BINLOG_FORMAT=row
DEFAULT_STORAGE_ENGINE=InnoDB
INNODB_AUTOINC_LOCK_MODE=2
BIND_ADDRESS=0.0.0.0
IRODS_SERVICE_ACCOUNT_NAME=irods
IRODS_SERVICE_ACCOUNT_GROUP=irods
IRODS_SERVER_ROLE=1
ODBC_DRIVER_FOR_MYSQL=2
IRODS_DATABASE_SERVER_HOSTNAME=localhost
IRODS_DATABASE_SERVER_PORT=3306
IRODS_DATABASE_NAME=ICAT
IRODS_DATABASE_USER_NAME=irods
IRODS_DATABASE_PASSWORD=temppassword
IRODS_DATABASE_USER_PASSWORD_SALT=tempsalt
IRODS_ZONE_NAME=tempZone
IRODS_PORT=1247
IRODS_PORT_RANGE_BEGIN=20000
IRODS_PORT_RANGE_END=20199
IRODS_CONTROL_PLANE_PORT=1248
IRODS_SCHEMA_VALIDATION=file:///var/lib/irods/configuration_schemas
IRODS_SERVER_ADMINISTRATOR_USER_NAME=rods
IRODS_SERVER_ZONE_KEY=TEMPORARY_zone_key
IRODS_SERVER_NEGOTIATION_KEY=TEMPORARY_32byte_negotiation_key
IRODS_CONTROL_PLANE_KEY=TEMPORARY__32byte_ctrl_plane_key
IRODS_SERVER_ADMINISTRATOR_PASSWORD=rods
IRODS_VAULT_DIRECTORY=/Vault
MYSQL_ROOT_PASSWORD=rods
```


### init-galera

`$ ./init-galera && docker attach --sig-proxy=false irods-galera-1`

```bash
#!/usr/bin/env bash

docker stop irods-galera-1
docker rm -fv irods-galera-1
sleep 2s
docker run -d --name irods-galera-1 -h galera-1.edc.renci.org \
    -v /var/galera/vault:/Vault \
    -v /var/galera/var_mysql:/var/lib/mysql \
    -v /var/galera/var_irods:/var/lib/irods \
    -v /var/galera/etc_irods:/etc/irods \
    -v /home/galera/init:/init \
    --env-file=/home/galera/galera1.env \
    -p 3306:3306 \
    -p 4444:4444 \
    -p 4567:4567 \
    -p 4568:4568 \
    -p 1247:1247 \
    -p 1248:1248 \
    -p 20000-20199:20000-20199 \
    mjstealey/irods-provider-galera:4.2.0 -ivd setup_irods.py

exit 0;
```

### mkresc

`$ ./mkresc galera1Resc`

```bash
#!/usr/bin/env bash

RESC=$1

docker exec -u irods irods-galera-1 iadmin mkresc $RESC unixfilesystem galera-1.edc.renci.org:/Vault

docker exec -u irods irods-galera-1 iadmin lr

exit 0;
```