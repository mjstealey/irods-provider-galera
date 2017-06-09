+++
date = "2017-05-28T20:54:43-04:00"
description = "Three node test script in Docker"
title = "Three node test script"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "3node"
    parent = "usage"
    weight = 6

+++

## Three node Docker network

A three node test script was created that demonstrates the basic principles of using the MariaDB Galera cluster as the iRODS catalog for multiple provider nodes.

![Galera clusture]({{<baseurl>}}/images/galeracluster.png)

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
docker run --rm mjstealey/irods-provider-galera:4.2.0 -h setup_irods.py

# init irods-galera-node-1
echo "### start irods-galera-node-1 and initialize cluster 'galera' with initialize.sql file ###"
docker run -d --name irods-galera-node-1 -h irods-galera-node-1 \
    --env-file=env/irods-galera-node-1.env \
    --net galeranet \
    --ip 172.18.0.2 \
    --add-host irods-galera-node-2:172.18.0.3 \
    --add-host irods-galera-node-3:172.18.0.4 \
    mjstealey/irods-provider-galera:4.2.0 -vi setup_irods.py

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

# init irods-galera-node-2
echo "### start irods-galera-node-2 and join cluster 'irods-galera' ###"
docker run -d --name irods-galera-node-2 -h irods-galera-node-2 \
    --env-file=env/irods-galera-node-2.env \
    --net galeranet \
    --ip 172.18.0.3 \
    --add-host irods-galera-node-1:172.18.0.2 \
    --add-host irods-galera-node-3:172.18.0.4 \
    mjstealey/irods-provider-galera:4.2.0 -vj setup_irods.py

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
    mjstealey/irods-provider-galera:4.2.0 -vj setup_irods.py

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
