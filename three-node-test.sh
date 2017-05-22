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