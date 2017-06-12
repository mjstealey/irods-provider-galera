+++
date = "2017-06-09T21:24:47-04:00"
description = "Local Area Network - local machine"
title = "LAN - local machine"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "lanlocal"
    parent = "poc"
    weight = 2

+++

## Three node Docker network

A three node test script was created that demonstrates the basic principles of using the MariaDB Galera cluster as the iRODS catalog for multiple provider nodes.

![Galera clusture]({{<baseurl>}}/images/tempzone.png)

The script does the following.

1. Creates a local docker network named **galeranet** so that known IP addresses can be assigned to each node
2. Stands up the initial **bootstrap** node using mostly defaults as set by the Docker image.
3. Stands up two additional nodes in series that join the cluster named **galera** as they discover others on the local **galeranet** network.

As each node completes it's stand up routine, it will report back the number of nodes participating as the `wsrep_cluster_size`, show the named databases including `ICAT`, grants for user **'irods'@'localhost'**, and finally print out all tables within the `ICAT` database.

Since this initial test was performed on a single VM using a docker network, it was not subjected to any rigorous external testing and only subject to simple iCommands to validate synchronization between nodes and partitioning between named node resource definitions. A dedicated set of [Galera VMs]({{<baseurl>}}/galera-vms) were established for the purpose of vetting the performance of the three node configuration in a more real world setting.

### three-node-test.sh

```bash
#!/usr/bin/env bash

REPO_DIR=$(pwd)

# create docker network if it does not exist
GALERANET=$(docker network inspect galeranet)
echo "### create docker network galeranet if it does not exist ###"
if [[ "${GALERANET}" = '[]' ]]; then
    docker network create --subnet=172.18.0.0/16 galeranet
fi

# stop / remove existing containers
echo "### stop / remove existing containers ###"
if [[ -n $(docker ps -a | grep galera-node) ]]; then
    docker stop irods-galera-node-1 irods-galera-node-2 irods-galera-node-3
    docker rm -fv irods-galera-node-1 irods-galera-node-2 irods-galera-node-3
fi

# show usage
echo "### show usage ###"
docker run --rm mjstealey/irods-provider-galera:4.2.1 -h setup_irods.py

# init irods-galera-node-1
echo "### start irods-galera-node-1 and initialize cluster 'galera' with initialize.sql file ###"
docker run -d --name irods-galera-node-1 -h irods-galera-node-1 \
    --env-file=env/irods-galera-node-1.env \
    --net galeranet \
    --ip 172.18.0.2 \
    --add-host irods-galera-node-2:172.18.0.3 \
    --add-host irods-galera-node-3:172.18.0.4 \
    mjstealey/irods-provider-galera:4.2.1 -vi setup_irods.py

exec 3>&2
exec 2> /dev/null
CL_SIZE=0
echo -n "Waiting for irods-galera-node-1 "
while [ "${CL_SIZE}" != '1' ]; do
    sleep 2s
    LINE=$(docker exec irods-galera-node-1 mysql -uroot -ptemppassword -e "SHOW STATUS LIKE 'wsrep_cluster_size';" | grep wsrep_cluster_size)
    CL_SIZE=$(echo ${LINE} | cut -d ' ' -f 2)
    echo -n "."
done
echo ""
exec 2>&3
echo "[node-1 MySQL]> SHOW STATUS LIKE 'wsrep_cluster_size';"
docker exec -ti irods-galera-node-1 mysql -uroot -ptemppassword -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
echo "[node-1 MySQL]> SHOW databases;"
docker exec -ti irods-galera-node-1 mysql -uroot -ptemppassword -e "SHOW databases;"
echo "[node-1 MySQL]> SHOW grants FOR 'irods'@'localhost';"
docker exec -ti irods-galera-node-1 mysql -uroot -ptemppassword ICAT -e \
"SHOW grants FOR 'irods'@'localhost';"
echo "[node-1]$ ienv"
docker exec -ti -u irods irods-galera-node-1 ienv

# init irods-galera-node-2
echo "### start irods-galera-node-2 and join cluster 'irods-galera' ###"
docker run -d --name irods-galera-node-2 -h irods-galera-node-2 \
    --env-file=env/irods-galera-node-2.env \
    --net galeranet \
    --ip 172.18.0.3 \
    --add-host irods-galera-node-1:172.18.0.2 \
    --add-host irods-galera-node-3:172.18.0.4 \
    mjstealey/irods-provider-galera:4.2.1 -vj setup_irods.py

exec 3>&2
exec 2> /dev/null
CL_SIZE=0
echo -n "Waiting for irods-galera-node-2 "
while [ "${CL_SIZE}" != '2' ]; do
    sleep 2s
    LINE=$(docker exec irods-galera-node-2 mysql -uroot -ptemppassword -e "SHOW STATUS LIKE 'wsrep_cluster_size';" | grep wsrep_cluster_size)
    CL_SIZE=$(echo ${LINE} | cut -d ' ' -f 2)
    echo -n "."
done
echo ""
exec 2>&3
echo "[node-2 MySQL]> SHOW STATUS LIKE 'wsrep_cluster_size';"
docker exec -ti irods-galera-node-2 mysql -uroot -ptemppassword -e "SHOW STATUS LIKE 'wsrep_cluster_size';"
echo "[node-2 MySQL]> SHOW databases;"
docker exec -ti irods-galera-node-2 mysql -uroot -ptemppassword -e "SHOW databases;"
echo "[node-2 MySQL]> SHOW grants FOR 'irods'@'localhost';"
docker exec -ti irods-galera-node-2 mysql -uroot -ptemppassword ICAT -e \
"SHOW grants FOR 'irods'@'localhost';"

# init irods-galera-node-3
echo "### start irods-galera-node-3 and join cluster 'galera' ###"
docker run -d --name irods-galera-node-3 -h irods-galera-node-3 \
    --env-file=env/irods-galera-node-3.env \
    --net galeranet \
    --ip 172.18.0.4 \
    --add-host irods-galera-node-1:172.18.0.2 \
    --add-host irods-galera-node-2:172.18.0.3 \
    mjstealey/irods-provider-galera:4.2.1 -vj setup_irods.py

exec 3>&2
exec 2> /dev/null
CL_SIZE=0
echo -n "Waiting for irods-galera-node-3 "
while [ "${CL_SIZE}" != '3' ]; do
    sleep 2s
    LINE=$(docker exec irods-galera-node-3 mysql -uroot -ptemppassword -e "SHOW STATUS LIKE 'wsrep_cluster_size';" | grep wsrep_cluster_size)
    CL_SIZE=$(echo ${LINE} | cut -d ' ' -f 2)
    echo -n "."
done
echo ""
exec 2>&3
echo "[node-3 MySQL]> SHOW STATUS LIKE 'wsrep_cluster_size';"
docker exec -ti irods-galera-node-3 mysql -uroot -ptemppassword -e \
"SHOW STATUS LIKE 'wsrep_cluster_size';"
echo "[node-3 MySQL]> SHOW databases;"
docker exec -ti irods-galera-node-3 mysql -uroot -ptemppassword -e "SHOW databases;"
echo "[node-3 MySQL]> SHOW STATUS LIKE 'wsrep_incoming_addresses';"
docker exec -ti irods-galera-node-3 mysql -uroot -ptemppassword -e \
"SHOW STATUS LIKE 'wsrep_incoming_addresses';"
echo "[node-3 MySQL]> SHOW grants FOR 'irods'@'localhost';"
docker exec -ti irods-galera-node-3 mysql -uroot -ptemppassword ICAT -e \
"SHOW grants FOR 'irods'@'localhost';"
echo "[node-3 MySQL]> SHOW FULL TABLES IN ICAT;"
docker exec -ti irods-galera-node-3 mysql -uroot -ptemppassword -e "SHOW FULL TABLES IN ICAT;"

exit 0;
```

### Expected output

```console
$ ./three-node-test.sh
Error: No such network: galeranet
### create docker network galeranet if it does not exist ###
e5ebed88443da32ca7e1dee88bfbbe00fcef4da097ea8cb4f2a58e1c5bef41a4
### stop / remove existing containers ###
### show usage ###
Unable to find image 'mjstealey/irods-provider-galera:4.2.1' locally
4.2.1: Pulling from mjstealey/irods-provider-galera
343b09361036: Pull complete
608343e5b0d0: Pull complete
91fb8ae89fb7: Pull complete
9b44cff09138: Pull complete
97f8885c0109: Pull complete
98c739205832: Pull complete
c00b8088a5b0: Pull complete
79b2cb416fdd: Pull complete
7937185edee5: Pull complete
7e502a328d7c: Pull complete
ccb66a531ac8: Pull complete
31f50ab8da11: Pull complete
0c0d109b7f83: Pull complete
5ab05f22c297: Pull complete
860a5b03ba2e: Pull complete
3be472c8635d: Pull complete
Digest: sha256:3e40975c4c310dbd089431f2533a56ffb0c3b68796d3d2007945fbd0208e0049
Status: Downloaded newer image for mjstealey/irods-provider-galera:4.2.1
iRODS Provider - Galera Cluster

docker-entrypoint [-hijvd] [-f filename.sql] [arguments]

options:
-h                    show brief help
-i                    initialize iRODS Galera cluster
-j                    join existing iRODS Galera cluster
-v                    verbose output
-d                    dump database as db.sql to volume mounted as /LOCAL/PATH:/init
-f filename.sql       provide SQL script to initialize database from volume mounted as /LOCAL/PATH:/init

Example:
  $ docker run --rm mjstealey/irods-provider-galera:4.2.1 -h               # show help
  $ docker run -d mjstealey/irods-provider-galera:4.2.1 -iv setup_irods.py # init with default settings

### start irods-galera-node-1 and initialize cluster 'galera' with initialize.sql file ###
cc51c3413306765208b8f8f308e65b190afb45c89571a71ad20079f538ea8e07
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
[node-1]$ ienv
irods_version - 4.2.1
irods_server_control_plane_encryption_algorithm - AES-256-CBC
schema_name - irods_environment
irods_transfer_buffer_size_for_parallel_transfer_in_megabytes - 4
irods_host - irods-galera-node-1
irods_zone_name - tempZone
irods_user_name - rods
irods_server_control_plane_encryption_num_hash_rounds - 16
irods_session_environment_file - /var/lib/irods/.irods/irods_environment.json.0
irods_port - 1247
irods_default_resource - demoResc
irods_home - /tempZone/home/rods
irods_encryption_num_hash_rounds - 16
irods_encryption_algorithm - AES-256-CBC
irods_default_hash_scheme - SHA256
irods_cwd - /tempZone/home/rods
irods_maximum_size_for_single_buffer_in_megabytes - 32
schema_version - v3
irods_encryption_salt_size - 8
irods_client_server_policy - CS_NEG_REFUSE
irods_server_control_plane_key - TEMPORARY__32byte_ctrl_plane_key
irods_client_server_negotiation - request_server_negotiation
irods_server_control_plane_port - 1248
irods_encryption_key_size - 32
irods_match_hash_policy - compatible
irods_environment_file - /var/lib/irods/.irods/irods_environment.json
irods_default_number_of_transfer_threads - 4
### start irods-galera-node-2 and join cluster 'irods-galera' ###
654b094fc5545b6671c77f8fa84fa37dbe4eaf2bb353434b5be5686fef65e90a
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
b51fcb1501ec5e17d493359496e8235ed5227006c3ce292b1f041b5e338d0c1d
Waiting for irods-galera-node-3 ..........
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
| wsrep_incoming_addresses | 172.18.0.2:3306,172.18.0.3:3306,172.18.0.4:3306 |
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
{{% panel theme="success" header="PASSED" %}}
Example docker status:

```console
$ docker ps
CONTAINER ID        IMAGE                                   COMMAND                  CREATED             STATUS              PORTS                                                               NAMES
b51fcb1501ec        mjstealey/irods-provider-galera:4.2.1   "/docker-entrypoin..."   44 minutes ago      Up 44 minutes       1247-1248/tcp, 3306/tcp, 4444/tcp, 4567-4568/tcp, 20000-20199/tcp   irods-galera-node-3
654b094fc554        mjstealey/irods-provider-galera:4.2.1   "/docker-entrypoin..."   45 minutes ago      Up 45 minutes       1247-1248/tcp, 3306/tcp, 4444/tcp, 4567-4568/tcp, 20000-20199/tcp   irods-galera-node-2
cc51c3413306        mjstealey/irods-provider-galera:4.2.1   "/docker-entrypoin..."   45 minutes ago      Up 45 minutes       1247-1248/tcp, 3306/tcp, 4444/tcp, 4567-4568/tcp, 20000-20199/tcp   irods-galera-node-1
```
{{% /panel %}}
