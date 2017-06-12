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

Three CentOS 7.3.1611 (Core) virtual machines (VMs) were stood up to establish an iRODS provider Galera cluster testbed. Each VM is configured with a user account named **galera** which has rights to run [Docker](https://www.docker.com) and not much else.

![Galera testbed]({{<baseurl>}}/images/galeratestbed.png)

## Design

The proof of concept has been designed to run in Docker and doesn't prohibit storing the files for iRODS and MariaDB to the host. Generally an iRODS system deployment would use service level accounts named "irods" and "mysql" to retain/own the iRODS service files and the MariaDB files respectively. The docker image used herein has defaulted these system users to be:

- **irods**: UID=996, GID=996
- **mysql**: UID=997, GID=997

If the user chooses to deploy the irods-provider-galera image using local volume mounts, then these **UID** and **GID** values would be found on the local system for the **user**:**group** in charge of the shared volumes. The UID and GID for both the **irods** and **mysql** user can be set at run-time to be any valid combination within the host system the container is being run from.

## setup

A set of directories in `/var` are set aside to mount to the **irods-provider-galera** container to hold the iRODS and MariaDB files. The following script outlines the creation and initial permissions for these directories.

Script `setup-galera`.

```bash
#!/usr/bin/env bash

sudo rm -rf /var/galera

sudo mkdir -p /var/galera/init
sudo mkdir -p /var/galera/vault
sudo mkdir -p /var/galera/var_mysql
sudo mkdir -p /var/galera/var_irods
sudo mkdir -p /var/galera/etc_irods

sudo chown -R galera:galera /var/galera

exit 0;
```

The user named **galera** will be in charge of running the **irods-provider-galera**, and has the following attributes.

```
$ id galera
uid=2112(galera) gid=2112(galera) groups=2112(galera),992(docker)
```

When instantiating the iRODS container we will set the environment variables of the **irods** and **mysql** users to use UIDs and GIDs that are locally available.

```
-e UID_MYSQL=2000 \ # UID that is unassigned on the localhost
-e GID_MYSQL=2112 \ # GID assigned to user galera on the localhost
-e UID_IRODS=2112 \ # UID assigned to user galera on the localhost
-e GID_IRODS=2112 \ # GID assigned to user galera on the localhost
```

View of `/var/galera` before **irods-provider-galera** is run:

```
$ ls -alh /var/galera/
total 4.0K
drwxr-xr-x   7 galera galera   77 Jun 11 11:34 .
drwxr-xr-x. 21 root   root   4.0K Jun 11 11:34 ..
drwxr-xr-x   2 galera galera    6 Jun 11 11:34 etc_irods
drwxr-xr-x   2 galera galera    6 Jun 11 11:34 init
drwxr-xr-x   2 galera galera    6 Jun 11 11:34 var_irods
drwxr-xr-x   2 galera galera    6 Jun 11 11:34 var_mysql
drwxr-xr-x   2 galera galera    6 Jun 11 11:34 vault
```

## Confifguration / Scripts

Containers are stood up and run in a similar fashion on each node. An `init-galera` script is defined on every node that makes use of a environment file to load the settings into the container at run-time. Nodes are stood up sequentially, with the first node being stood up in **bootstrap** mode, and subsequent containers being stood up in **join** mode.

### init-galera

Example as found on node **galera-1.edc.renci.org**

Full output from `$ ./init-galera && docker attach --sig-proxy=false irods-galera-1` is [here]({{<baseurl>}}/init-galera)

Script `init-galera`.

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
    mjstealey/irods-provider-galera:latest -ivd setup_irods.py

exit 0;
```

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

### mkresc

`$ ./mkresc galera1Resc`

```bash
#!/usr/bin/env bash

RESC=$1

docker exec -u irods irods-galera-1 iadmin mkresc $RESC unixfilesystem galera-1.edc.renci.org:/Vault

docker exec -u irods irods-galera-1 iadmin lr

exit 0;
```

Example:

```console
$ ./mkresc galera1Resc
Creating resource:
Name:		"galera1Resc"
Type:		"unixfilesystem"
Host:		"galera-1.edc.renci.org"
Path:		"/Vault"
Context:	""
bundleResc
demoResc
galera1Resc
```

Nodes **galera-2.edc.renci.org** and **galera-3.edc.renci.org** differ in the following:

- Environment files differ respectively: `galera2.env` and `galera3.env` (Example)
  - `WSREP_NODE_ADDRESS='172.25.8.172'`
  - `WSREP_NODE_NAME='galera-2'`
- Join instead of bootstrap: `mjstealey/irods-provider-galera:latest -jv setup_irods.py`
- Resources are resident to each node: `galera2Resc` and `galera3Resc`

Example from galera-2.edc.renci.org

```console
$ ./mkresc galera2Resc
Creating resource:
Name:		"galera2Resc"
Type:		"unixfilesystem"
Host:		"galera-2.edc.renci.org"
Path:		"/Vault"
Context:	""
bundleResc
demoResc
galera1Resc
galera2Resc
```

Example from galera-3.edc.renci.org

```console
$ ./mkresc galera3Resc
Creating resource:
Name:		"galera3Resc"
Type:		"unixfilesystem"
Host:		"galera-3.edc.renci.org"
Path:		"/Vault"
Context:	""
bundleResc
demoResc
galera1Resc
galera2Resc
galera3Resc
```

Example `docker ps` output from galera-1.edc.renci.org:

```console
$ docker ps
CONTAINER ID        IMAGE                                    COMMAND                  CREATED             STATUS              PORTS                                                                                                                                                      NAMES
203fd120fd2a        mjstealey/irods-provider-galera:latest   "/docker-entrypoin..."   20 minutes ago      Up 20 minutes       0.0.0.0:1247-1248->1247-1248/tcp, 0.0.0.0:3306->3306/tcp, 0.0.0.0:4444->4444/tcp, 0.0.0.0:4567-4568->4567-4568/tcp, 0.0.0.0:20000-20199->20000-20199/tcp   irods-galera-1
```

## Local directory contents

Host directories are used as volume mounts to the irods-provider-galera container and defined as follows:

- `/var/galera/vault` --> `/Vault`
- `/var/galera/var_mysql` --> `/var/lib/mysql`
- `/var/galera/var_irods` --> `/var/lib/irods`
- `/var/galera/etc_irods` --> `/etc/irods`
- `/home/galera/init` --> `/init`

**/var/galera/vault** --> **/Vault** mount (remap of Vault from /var/lib/irods/Vault)

```console
$ ls -lah /var/galera/vault/
total 0
drwxr-xr-x 3 galera galera 17 Jun 11 13:00 .
drwxr-xr-x 7 galera galera 77 Jun 11 11:34 ..
drwxr-x--- 3 galera galera 17 Jun 11 13:00 home
```

**/var/galera/var_mysql** --> **/var/lib/mysql** mount

```console
$ ls -lah /var/galera/var_mysql/
total 301M
drwxr-xr-x 5   2000 galera 4.0K Jun 11 13:10 .
drwxr-xr-x 7 galera galera   77 Jun 11 11:34 ..
-rw-rw---- 1   2000 galera  16K Jun 11 13:00 aria_log.00000001
-rw-rw---- 1   2000 galera   52 Jun 11 13:00 aria_log_control
-rw-rw---- 1   2000 galera  19K Jun 11 13:10 galera-1.edc.renci.org.err
-rw-rw---- 1   2000 galera    5 Jun 11 13:00 galera-1.edc.renci.org.pid
-rw------- 1   2000 galera 129M Jun 11 13:10 galera.cache
-rw-rw---- 1   2000 galera  113 Jun 11 13:10 grastate.dat
-rw-rw---- 1   2000 sssd    217 Jun 11 13:09 gvwstate.dat
-rw-rw---- 1   2000 galera  76M Jun 11 13:00 ibdata1
-rw-rw---- 1   2000 galera  48M Jun 11 13:00 ib_logfile0
-rw-rw---- 1   2000 galera  48M May 21 22:25 ib_logfile1
drwx------ 2   2000 galera 4.0K Jun 11 13:00 ICAT
-rw-rw---- 1   2000 galera    0 Jun 11 12:59 multi-master.info
drwx--x--x 2   2000 galera 4.0K May 21 22:25 mysql
srwxrwxrwx 1   2000 galera    0 Jun 11 13:00 mysql.sock
drwx------ 2   2000 galera   19 May 21 22:25 performance_schema
-rw-rw---- 1   2000 sssd     41 Jun 11 13:10 rsync_sst_complete
-rw-rw---- 1   2000 galera  24K Jun 11 13:00 tc.log
```

**/var/galera/var_irods** --> **/var/lib/irods** mount

```console
$ ls -lah /var/galera/var_irods/
total 28K
drwxr-xr-x 11 galera galera 4.0K Jun 11 12:59 .
drwxr-xr-x  7 galera galera   77 Jun 11 11:34 ..
drwxr-xr-x  4 galera galera   32 Jun  9 19:34 clients
drwxr-xr-x  4 galera galera   40 Jun  9 19:34 config
drwxr-xr-x  3 galera galera   15 Jun  9 19:34 configuration_schemas
drwx------  2 galera galera   49 Jun 11 12:59 .irods
-r-xr--r--  1 galera galera  283 Jun  8 02:30 irodsctl
drwxr-xr-x  3 galera galera   85 Jun 11 13:00 log
drwxr-xr-x  2 galera galera   94 Jun  9 19:34 msiExecCmd_bin
-rw-r--r--  1 galera galera  130 Jun 11 13:00 .odbc.ini
drwxr-xr-x  3 galera galera 4.0K Jun  9 19:34 packaging
drwxr-xr-x  3 galera galera 4.0K Jun  9 19:34 scripts
drwxr-xr-x  3 galera galera   63 Jun  9 19:34 test
-rw-------  1 galera galera  224 Jun 11 12:59 VERSION.json
-rw-r--r--  1 galera galera  166 Jun  8 02:31 VERSION.json.dist
```

**/var/galera/etc_irods** --> **/etc/irods** mount

```console
$ ls -lah /var/galera/etc_irods/
total 72K
drwxr-xr-x 2 galera galera 4.0K Jun 11 13:00 .
drwxr-xr-x 7 galera galera   77 Jun 11 11:34 ..
-rw-r--r-- 1 galera galera 5.0K Jun 11 13:00 core.dvm
-rw-r--r-- 1 galera galera  831 Jun 11 13:00 core.fnm
-rw-r--r-- 1 galera galera  38K Jun 11 13:00 core.re
-rw-r--r-- 1 galera galera  106 Jun 11 13:00 host_access_control_config.json
-rw-r--r-- 1 galera galera   90 Jun 11 13:00 hosts_config.json
-rw------- 1 galera galera 3.4K Jun 11 12:59 server_config.json
-rw-r--r-- 1 galera galera   64 Jun 11 12:59 service_account.config
```

**/home/galera/init** --> **/init** mount

```console
$ ls -lah /var/galera/init/
total 0
drwxr-xr-x 2 galera galera  6 Jun 11 11:34 .
drwxr-xr-x 7 galera galera 77 Jun 11 11:34 ..
```
