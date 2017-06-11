+++
date = "2017-05-28T21:26:16-04:00"
description = "Galera VMs used for testing"
title = "Galera cluster - VMs"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "vms"
    parent = "poc"
    weight = 1

+++

Three CentOS Linux release 7.3.1611 (Core) virtual machines (VMs) were stood up to establish an iRODS provider Galera cluster testbed. Each VM is configured with a user account named **galera** which has rights to run [Docker](https://www.docker.com) and not much else.

## Design

Though the proof of concept has been designed to run in Docker, it doesn't prohibit storing the files for iRODS and MariaDB to the host. In general a system would employ service level accounts named "irods" and "mysql" to retain/own the iRODS service files and the MariaDB files respectively. The docker model used herein has defaulted these system user values to be:

- irods: UID=996, GID=996
- mysql: UID=997, GID=997

These UID and GID values would then be found on the local system if the user chooses to mount local volumes to the irods-provider-galera container at runtime.

```
$ id galera
uid=2112(galera) gid=2112(galera) groups=2112(galera),992(docker)
```

Set environment variables to use local UIDs and GIDs.

```
    -e UID_MYSQL=2000 \
    -e GID_MYSQL=2112 \
    -e UID_IRODS=2112 \
    -e GID_IRODS=2112 \
```

Before:

```
$ ls -alh /var/galera/
total 4.0K
drwxr-xr-x   7 galera galera   77 May 29 13:28 .
drwxr-xr-x. 21 root   root   4.0K May 29 13:28 ..
drwxr-xr-x   2 galera galera    6 May 29 13:28 etc_irods
drwxr-xr-x   2 galera galera    6 May 29 13:28 init
drwxr-xr-x   2 galera galera    6 May 29 13:28 var_irods
drwxr-xr-x   2 galera galera    6 May 29 13:28 var_mysql
drwxr-xr-x   2 galera galera    6 May 29 13:28 vault
```

After:

```
$ ls -lah /var/galera/
total 16K
drwxr-xr-x   7 galera galera   77 May 29 13:28 .
drwxr-xr-x. 21 root   root   4.0K May 29 13:28 ..
drwxr-xr-x   2 galera galera 4.0K May 29 13:32 etc_irods
drwxr-xr-x   2 galera galera    6 May 29 13:28 init
drwxr-xr-x  11 galera galera 4.0K May 29 13:32 var_irods
drwxr-xr-x   5   2000 galera 4.0K May 29 13:32 var_mysql
drwxr-xr-x   3 galera galera   17 May 29 13:32 vault
```

## Confifguration / Scripts

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
    -e UID_MYSQL=2000 \
    -e GID_MYSQL=2112 \
    -e UID_IRODS=2112 \
    -e GID_IRODS=2112 \
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
    mjstealey/irods-provider-galera:4.2.0 -jv setup_irods.py

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

## Local directory contents

Host directories are used as volume mounts to the irods-provider-galera container and defined as follows:

- `/var/galera/vault` --> `/Vault`
- `/var/galera/var_mysql` --> `/var/lib/mysql`
- `/var/galera/var_irods` --> `/var/lib/irods`
- `/var/galera/etc_irods` --> `/etc/irods`
- `/home/galera/init` --> `/init`


**/etc/irods** mount

```console
$ ls -lah /var/galera/etc_irods/
total 72K
drwxr-xr-x 2 galera galera 4.0K May 29 13:32 .
drwxr-xr-x 7 galera galera   77 May 29 13:28 ..
-rw-r--r-- 1 galera galera 5.0K May 29 13:32 core.dvm
-rw-r--r-- 1 galera galera  831 May 29 13:32 core.fnm
-rw-r--r-- 1 galera galera  39K May 29 13:32 core.re
-rw-r--r-- 1 galera galera  106 May 29 13:32 host_access_control_config.json
-rw-r--r-- 1 galera galera   90 May 29 13:32 hosts_config.json
-rw------- 1 galera galera 3.5K May 29 13:32 server_config.json
-rw-r--r-- 1 galera galera   64 May 29 13:32 service_account.config
```

```console
[galera@galera-1 ~]$ ls -lah /var/galera/init/
total 0
drwxr-xr-x 2 galera galera  6 May 29 13:28 .
drwxr-xr-x 7 galera galera 77 May 29 13:28 ..
```

**/var/lib/irods** mount

```console
[galera@galera-1 ~]$ ls -lah /var/galera/var_irods/
total 28K
drwxr-xr-x 11 galera galera 4.0K May 29 13:32 .
drwxr-xr-x  7 galera galera   77 May 29 13:28 ..
drwxr-xr-x  4 galera galera   32 May 29 10:28 clients
drwxr-xr-x  4 galera galera   40 May 29 10:28 config
drwxr-xr-x  3 galera galera   15 May 29 10:28 configuration_schemas
drwx------  2 galera galera   49 May 29 13:32 .irods
-r-xr--r--  1 galera galera  283 Nov 13  2016 irodsctl
drwxr-xr-x  3 galera galera   85 May 29 13:32 log
drwxr-xr-x  2 galera galera   94 May 29 10:28 msiExecCmd_bin
-rw-r--r--  1 galera galera  130 May 29 13:32 .odbc.ini
drwxr-xr-x  3 galera galera 4.0K May 29 10:28 packaging
drwxr-xr-x  3 galera galera 4.0K May 29 10:28 scripts
drwxr-xr-x  3 galera galera   63 May 29 10:28 test
-rw-------  1 galera galera  224 May 29 13:32 VERSION.json
-rw-r--r--  1 galera galera  166 Nov 13  2016 VERSION.json.dist
```

**/var/lib/mysql** mount

```console
[galera@galera-1 ~]$ ls -lah /var/galera/var_mysql/
total 301M
drwxr-xr-x 5   2000 galera 4.0K May 29 13:32 .
drwxr-xr-x 7 galera galera   77 May 29 13:28 ..
-rw-rw---- 1   2000 galera  16K May 29 13:32 aria_log.00000001
-rw-rw---- 1   2000 galera   52 May 29 13:32 aria_log_control
-rw-rw---- 1   2000 galera  17K May 29 13:32 galera-1.edc.renci.org.err
-rw-rw---- 1   2000 galera    5 May 29 13:32 galera-1.edc.renci.org.pid
-rw------- 1   2000 galera 129M May 29 13:32 galera.cache
-rw-rw---- 1   2000 galera  113 May 29 13:32 grastate.dat
-rw-rw---- 1   2000 galera  264 May 29 13:32 gvwstate.dat
-rw-rw---- 1   2000 galera  76M May 29 13:32 ibdata1
-rw-rw---- 1   2000 galera  48M May 29 13:32 ib_logfile0
-rw-rw---- 1   2000 galera  48M May 29 13:32 ib_logfile1
drwx------ 2   2000 galera 4.0K May 29 13:32 ICAT
-rw-rw---- 1   2000 galera    0 May 29 13:32 multi-master.info
drwx--x--x 2   2000 galera 4.0K May 21 22:25 mysql
srwxrwxrwx 1   2000 galera    0 May 29 13:32 mysql.sock
drwx------ 2   2000 galera   19 May 21 22:25 performance_schema
-rw-rw---- 1   2000 galera  24K May 29 13:32 tc.log
```

**/Vault** mount (remap of Vault from /var/lib/irods/Vault)

```console
[galera@galera-1 ~]$ ls -lah /var/galera/vault/
total 0
drwxr-xr-x 3 galera galera 17 May 29 13:32 .
drwxr-xr-x 7 galera galera 77 May 29 13:28 ..
drwxr-x--- 3 galera galera 17 May 29 13:32 home
```
