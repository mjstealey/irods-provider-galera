#!/usr/bin/env bash

pushd ..
REPO_DIR=$(pwd)
popd

# create docker network if it does not exist
if [[ -n $(docker network inspect galeranet | grep Error) ]]; then
    docker network create --subnet=172.18.0.0/16 galeranet
fi

# stop / remove existing containers
if [[ -n $(docker ps -a | grep irods-galera) ]]; then
    docker stop irods-galera-1 irods-galera-2 irods-galera-3
    docker rm -fv irods-galera-1 irods-galera-2 irods-galera-3
fi

# configure irods-galera-1
docker run -d --name irods-galera-1 -h irods-galera-1 \
    -v ${REPO_DIR}/init:/init \
    -v /home/${USER}/galera1:/Vault \
    -e MYSQL_ROOT_PASSWORD=password \
    --env-file=${REPO_DIR}/env/irods-galera-1.env \
    --net galeranet \
    --ip 172.18.0.2 \
    --add-host irods-galera-2:172.18.0.3 \
    --add-host irods-galera-3:172.18.0.4 \
    irods-galera setup_irods.py --init

for pc in $(seq 15 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

# configure irods-galera-2
docker run -d --name irods-galera-2 -h irods-galera-2 \
    -v ${REPO_DIR}/init:/init \
    -v /home/${USER}/galera2:/Vault \
    -e MYSQL_ROOT_PASSWORD=password \
    --env-file=${REPO_DIR}/env/irods-galera-2.env \
    --net galeranet \
    --ip 172.18.0.3 \
    --add-host irods-galera-1:172.18.0.2 \
    --add-host irods-galera-3:172.18.0.4 \
    irods-galera setup_irods.py --init

for pc in $(seq 15 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

# configure irods-galera-3
docker run -d --name irods-galera-3 -h irods-galera-3 \
    -v ${REPO_DIR}/init:/init \
    -v /home/${USER}/galera3:/Vault \
    -e MYSQL_ROOT_PASSWORD=password \
    --env-file=${REPO_DIR}/env/irods-galera-3.env \
    --net galeranet \
    --ip 172.18.0.4 \
    --add-host irods-galera-1:172.18.0.2 \
    --add-host irods-galera-2:172.18.0.3 \
    irods-galera setup_irods.py --init

for pc in $(seq 30 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

echo "### Docker ps ###"
docker ps

# configure irods-galera-1
docker cp ${REPO_DIR}/scripts/irods-galera-1.sh irods-galera-1:/irods-galera-1.sh
docker exec irods-galera-1 gosu root chmod +x /irods-galera-1.sh
docker exec irods-galera-1 gosu root chown irods:irods /irods-galera-1.sh
docker exec irods-galera-1 gosu irods /irods-galera-1.sh
echo "### ienv irods-galera-1 ###"
docker exec irods-galera-1 gosu irods ienv

# configure irods-galera-2
for pc in $(seq 5 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done
docker cp ${REPO_DIR}/scripts/irods-galera-2.sh irods-galera-2:/irods-galera-2.sh
docker exec irods-galera-2 gosu root chmod +x /irods-galera-2.sh
docker exec irods-galera-2 gosu root chown irods:irods /irods-galera-2.sh
docker exec irods-galera-2 gosu irods /irods-galera-2.sh
echo "### ienv irods-galera-2 ###"
docker exec irods-galera-2 gosu irods ienv

# configure irods-galera-3
for pc in $(seq 5 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done
docker cp ${REPO_DIR}/scripts/irods-galera-3.sh irods-galera-3:/irods-galera-3.sh
docker exec irods-galera-3 gosu root chmod +x /irods-galera-3.sh
docker exec irods-galera-3 gosu root chown irods:irods /irods-galera-3.sh
docker exec irods-galera-3 gosu irods /irods-galera-3.sh
echo "### ienv irods-galera-3 ###"
docker exec irods-galera-3 gosu irods ienv

# list resources
echo "### list resources in galeraZone ###"
docker exec irods-galera-1 gosu irods /bin/bash -c 'iadmin lr'

# demonstrate functionality
echo "### demonstrate functionality ###"
echo "create file named irods-galera-1.txt on irods-galera-1 and iput to resource galera2"
docker exec irods-galera-1 gosu irods /bin/bash -c 'ienv > /var/lib/irods/$(hostname).txt'
docker exec irods-galera-1 gosu irods /bin/bash -c 'iput -R galera2 /var/lib/irods/$(hostname).txt'

echo "create file named irods-galera-2.txt on irods-galera-2 and iput to resource galera3"
docker exec irods-galera-2 gosu irods /bin/bash -c 'ienv > /var/lib/irods/$(hostname).txt'
docker exec irods-galera-2 gosu irods /bin/bash -c 'iput -R galera3 /var/lib/irods/$(hostname).txt'

echo "create file named irods-galera-3.txt on irods-galera-3 and iput to resource galera1"
docker exec irods-galera-3 gosu irods /bin/bash -c 'ienv > /var/lib/irods/$(hostname).txt'
docker exec irods-galera-3 gosu irods /bin/bash -c 'iput -R galera1 /var/lib/irods/$(hostname).txt'

echo "list resources as they are seen from irods-galera-1"
docker exec irods-galera-1 gosu irods /bin/bash -c 'ils -Lr'

exit 0;