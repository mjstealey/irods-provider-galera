# irods-provider-galera

**WORK IN PROGRESS**

iRODS provider that has the iCAT database back-ended by MariaDB Galera cluster in Docker

Based on: [mjstealey/mariadb-galera](https://github.com/mjstealey/mariadb-galera) using [centos:7](https://hub.docker.com/_/centos/)

## Supported tags and respective Dockerfile links

- 4.2.0, latest ([4.2.0/Dockerfile](https://github.com/mjstealey/irods-provider-galera/blob/master/4.2.0/Dockerfile))

### Pull image from dockerhub

Reference: [mjstealey/irods-provider-galera/](https://hub.docker.com/r/mjstealey/irods-provider-galera/)

```bash
docker pull mjstealey/irods-provider-galera:4.2.0
```

### Building locally

```
$ git clone https://github.com/mjstealey/irods-provider-galera.git
$ cd irods-provider-galera/4.2.0/
$ docker build -t irods-provider-galera .
```


## Example

### three-node-test.sh

This script demonstrates how to stand up a three node iRODS provider Galera cluster in a local docker network named **galeranet**.

A database named `ICAT` is created and initialized by container **irods-galera-node-1** based on the image defaults. The user could also initialize the ICAT database using a custom sql script shared from the host. As containers **irods-galera-node-2** and **irods-galera-node-3** are created they will join the cluster as defined by `WSREP_CLUSTER_ADDRESS`.

The definition for each example node can be found in the `env/` directory.

When the script is run output similar to the following should be observed:

```
$ ./three-node-test.sh
### create docker network galeranet if it does not exist ###
### stop / remove existing containers ###
irods-galera-node-1
irods-galera-node-2
irods-galera-node-3
irods-galera-node-1
irods-galera-node-2
irods-galera-node-3
### show usage ###
iRODS Provider - Galera Cluster

docker-entrypoint.sh [-hijvd] [-f filename.sql] [arguments]

options:
-h                    show brief help
-i                    initialize iRODS Galera cluster
-j                    join existing iRODS Galera cluster
-v                    verbose output
-d                    dump database as db.sql to volume mounted as /LOCAL/PATH:/init
-f filename.sql       provide SQL script to initialize database from volume mounted as /LOCAL/PATH:/init

Example: 
  $ docker run --rm mjstealey/irods-provider-galera:4.2.0 -h               # show help
  $ docker run -d mjstealey/irods-provider-galera:4.2.0 -iv setup_irods.py # init with default settings
  
### start irods-galera-node-1 and initialize cluster 'galera' with initialize.sql file ###
c88d3a730157ab47124844288a916a69b5cd172208bea8599b3c3324f289a278
Waiting for irods-galera-node-1 ........
[node-1 MySQL]> SHOW STATUS LIKE 'wsrep_cluster_size';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 1     |
+--------------------+-------+
[node-1 MySQL]> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| ICAT               |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
[node-1 MySQL]> SHOW grants FOR 'irods'@'localhost';
+--------------------------------------------------------------------------------------------------------------+
| Grants for irods@localhost                                                                                   |
+--------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'irods'@'localhost' IDENTIFIED BY PASSWORD '*60E38376E2C974797971A03D9BEEF1F5EB169FEA' |
| GRANT ALL PRIVILEGES ON `ICAT`.* TO 'irods'@'localhost'                                                      |
+--------------------------------------------------------------------------------------------------------------+
### start irods-galera-node-2 and join cluster 'irods-galera' ###
6550de449e727405557f2042f43cd9947e8adac6954f3f6f5a40205aa8c06446
Waiting for irods-galera-node-2 ..........
[node-2 MySQL]> SHOW STATUS LIKE 'wsrep_cluster_size';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 2     |
+--------------------+-------+
[node-2 MySQL]> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| ICAT               |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
[node-2 MySQL]> SHOW grants FOR 'irods'@'localhost';
+--------------------------------------------------------------------------------------------------------------+
| Grants for irods@localhost                                                                                   |
+--------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'irods'@'localhost' IDENTIFIED BY PASSWORD '*60E38376E2C974797971A03D9BEEF1F5EB169FEA' |
| GRANT ALL PRIVILEGES ON `ICAT`.* TO 'irods'@'localhost'                                                      |
+--------------------------------------------------------------------------------------------------------------+
### start irods-galera-node-3 and join cluster 'galera' ###
fe46da1faf9f9417243f989f2a17d939b45f2df1b88ea5077594af2c594d3521
Waiting for irods-galera-node-3 ...........
[node-3 MySQL]> SHOW STATUS LIKE 'wsrep_cluster_size';
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 3     |
+--------------------+-------+
[node-3 MySQL]> SHOW databases;
+--------------------+
| Database           |
+--------------------+
| ICAT               |
| information_schema |
| mysql              |
| performance_schema |
+--------------------+
[node-3 MySQL]> SHOW STATUS LIKE 'wsrep_incoming_addresses';
+--------------------------+-------------------------------------------------+
| Variable_name            | Value                                           |
+--------------------------+-------------------------------------------------+
| wsrep_incoming_addresses | 172.18.0.4:3306,172.18.0.2:3306,172.18.0.3:3306 |
+--------------------------+-------------------------------------------------+
[node-3 MySQL]> SHOW grants FOR 'irods'@'localhost';
+--------------------------------------------------------------------------------------------------------------+
| Grants for irods@localhost                                                                                   |
+--------------------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO 'irods'@'localhost' IDENTIFIED BY PASSWORD '*60E38376E2C974797971A03D9BEEF1F5EB169FEA' |
| GRANT ALL PRIVILEGES ON `ICAT`.* TO 'irods'@'localhost'                                                      |
+--------------------------------------------------------------------------------------------------------------+
[node-3 MySQL]> SHOW FULL TABLES IN ICAT;
+-------------------------+------------+
| Tables_in_ICAT          | Table_type |
+-------------------------+------------+
| R_COLL_MAIN             | BASE TABLE |
| R_DATA_MAIN             | BASE TABLE |
| R_GRID_CONFIGURATION    | BASE TABLE |
| R_META_MAIN             | BASE TABLE |
| R_MICROSRVC_MAIN        | BASE TABLE |
| R_MICROSRVC_VER         | BASE TABLE |
| R_OBJT_ACCESS           | BASE TABLE |
| R_OBJT_AUDIT            | BASE TABLE |
| R_OBJT_DENY_ACCESS      | BASE TABLE |
| R_OBJT_METAMAP          | BASE TABLE |
| R_ObjectId_seq_tbl      | BASE TABLE |
| R_QUOTA_MAIN            | BASE TABLE |
| R_QUOTA_USAGE           | BASE TABLE |
| R_RESC_GROUP            | BASE TABLE |
| R_RESC_MAIN             | BASE TABLE |
| R_RULE_BASE_MAP         | BASE TABLE |
| R_RULE_DVM              | BASE TABLE |
| R_RULE_DVM_MAP          | BASE TABLE |
| R_RULE_EXEC             | BASE TABLE |
| R_RULE_FNM              | BASE TABLE |
| R_RULE_FNM_MAP          | BASE TABLE |
| R_RULE_MAIN             | BASE TABLE |
| R_SERVER_LOAD           | BASE TABLE |
| R_SERVER_LOAD_DIGEST    | BASE TABLE |
| R_SPECIFIC_QUERY        | BASE TABLE |
| R_TICKET_ALLOWED_GROUPS | BASE TABLE |
| R_TICKET_ALLOWED_HOSTS  | BASE TABLE |
| R_TICKET_ALLOWED_USERS  | BASE TABLE |
| R_TICKET_MAIN           | BASE TABLE |
| R_TOKN_MAIN             | BASE TABLE |
| R_USER_AUTH             | BASE TABLE |
| R_USER_GROUP            | BASE TABLE |
| R_USER_MAIN             | BASE TABLE |
| R_USER_PASSWORD         | BASE TABLE |
| R_USER_SESSION_KEY      | BASE TABLE |
| R_ZONE_MAIN             | BASE TABLE |
+-------------------------+------------+
```

Configuration for **irods-galera-node-1** as `env/irods-galera-node-1.env`:

```
WSREP_ON=ON
WSREP_PROVIDER=/usr/lib64/galera/libgalera_smm.so
WSREP_PROVIDER_OPTIONS=
WSREP_CLUSTER_ADDRESS='gcomm://172.18.0.2,172.18.0.3,172.18.0.4'
WSREP_CLUSTER_NAME='galera'
WSREP_NODE_ADDRESS='172.18.0.2'
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
IRODS_VAULT_DIRECTORY=/var/lib/irods/iRODS/Vault
MYSQL_ROOT_PASSWORD=temppassword
```

Other nodes are defined in a similar fashion, needing only to change the settings for `WSREP_NODE_ADDRESS` and `WSREP_NODE_NAME` accordingly.

### WAN

If using over WAN additional parameters are available for `WSREP_PROVIDER_OPTIONS `, and should be modified according to use case. [Configuration tips](http://galeracluster.com/documentation-webpages/configurationtips.html)

Full set of [galera cluster system variables](https://mariadb.com/kb/en/mariadb/galera-cluster-system-variables/)

Example (should appear all in one line, seperated here for readability):

```
WSREP_PROVIDER_OPTIONS='evs.keepalive_period=PT3S;
  evs.suspect_timeout=PT30S;
  evs.inactive_timeout=PT1M;
  evs.install_timeout=PT1M;
  evs.join_retrans_period=PT1.0S'
```
