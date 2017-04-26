#!/usr/bin/env bash

pushd ..
REPO_DIR=$(pwd)
popd

# clean up from prior run
echo "### clean up from prior run ###"
for i in 1 2 3; do
    if [[ ! -d /home/${USER}/galera${i} ]]; then
        mkdir -p /home/${USER}/galera${i}
    else
        if [[ $(ls -A /home/${USER}/galera${i}) ]]; then
            sudo rm -rf ~/galera${i}/*
        fi
    fi
done

# create docker network if it does not exist
echo "### create docker network galeranet if it does not exist ###"
if [[ -n $(docker network inspect galeranet | grep Error) ]]; then
    docker network create --subnet=172.18.0.0/16 galeranet
fi

# stop / remove existing containers
echo "### stop / remove existing containers ###"
if [[ -n $(docker ps -a | grep irods-galera) ]]; then
    docker stop irods-galera-1 irods-galera-2 irods-galera-3
    docker rm -fv irods-galera-1 irods-galera-2 irods-galera-3
fi

_init_galera() {
    HOST_NAME=${1}
    HOST_IP=${2}
    ADD_HOST_IP_1=${3}
    ADD_HOST_IP_2=${4}
    docker run -d --name ${HOST_NAME} -h ${HOST_NAME} \
        -v ${REPO_DIR}/init:/init \
        -v /home/${USER}/galera${HOST_NAME: -1}:/Vault \
        -e MYSQL_ROOT_PASSWORD=password \
        --env-file=${REPO_DIR}/env/${HOST_NAME}.env \
        --net galeranet \
        --ip ${HOST_IP} \
        --add-host irods-galera-$(expr ${ADD_HOST_IP_1: -1} - 1):${ADD_HOST_IP_1} \
        --add-host irods-galera-$(expr ${ADD_HOST_IP_2: -1} - 1):${ADD_HOST_IP_2} \
        irods-galera setup_irods.py --init
}

# configure irods-galera-1
echo "### init irods-galera-1 ###"
_init_galera irods-galera-1 172.18.0.2 172.18.0.3 172.18.0.4
for pc in $(seq 15 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

# configure irods-galera-2
echo "### init irods-galera-2 ###"
_init_galera irods-galera-2 172.18.0.3 172.18.0.2 172.18.0.4
for pc in $(seq 15 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

# configure irods-galera-3
echo "### init irods-galera-3 ###"
_init_galera irods-galera-3 172.18.0.4 172.18.0.2 172.18.0.3
for pc in $(seq 30 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

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
G1='[rods@irods-galera-1]$'
CMD='iadmin lr'
echo ${G1}" "${CMD}
docker exec irods-galera-1 gosu irods ${CMD}

# demonstrate functionality
echo "### create rodsuser named bob with password bob ###"
G2='[rods@irods-galera-2]$'
CMD='iadmin mkuser bob rodsuser'
echo ${G2}" "${CMD}
docker exec irods-galera-2 gosu irods ${CMD}
CMD='iadmin moduser bob password bob'
echo ${G2}" "${CMD}
docker exec irods-galera-2 gosu irods ${CMD}

echo "### add files as user bob to each galera resource ###"
BOB='[bob@localhost]$'
CMD='iput -R galera2 AAAAA.txt'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.2 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

CMD='iput -R galera3 BBBBB.txt'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.3 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

CMD='iput -R galera1 CCCCC.txt'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.4 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

echo "### show bob's files in each resource in iRODS ###"
G3='[rods@irods-galera-3]$'
CMD='ils -Lr /galeraZone/home/bob'
echo ${G3}" "${CMD}
docker exec irods-galera-3 gosu irods ${CMD}
echo "### show bob's files in each Vault ###"
LOCUSER='[user@localhost]$'
echo ${LOCUSER}" ls -alh /home/${USER}/galera1/home/bob"
sudo ls -alh /home/${USER}/galera1/home/bob
echo ${LOCUSER}" ls -alh /home/${USER}/galera2/home/bob"
sudo ls -alh /home/${USER}/galera2/home/bob
echo ${LOCUSER}" ls -alh /home/${USER}/galera3/home/bob"
sudo ls -alh /home/${USER}/galera3/home/bob

# shut down irods-galera-2
echo "### shut down irods-galera-2 ###"
echo ${LOCUSER}" docker stop irods-galera-2 && docker rm -fv irods-galera-2"
docker stop irods-galera-2 && docker rm -fv irods-galera-2
echo ${LOCUSER}" docker ps -a"
docker ps -a

# iput new resource into galera3
echo "### iput new resource into galera3 ###"
CMD='iput -R galera3 DDDDD.txt'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.4 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

CMD='ils -Lr'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.4 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

# attempt to get file from galera2
echo "### attempt to get file from galera2 ###"
CMD='iget AAAAA.txt bob-AAAAA.txt'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.4 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

# bring back irods-galera-2
echo "### bring back irods-galera-2 ###"
echo "### init irods-galera-2 ###"
_init_galera irods-galera-2 172.18.0.3 172.18.0.2 172.18.0.4
for pc in $(seq 30 -1 1); do
    echo -ne "$pc ...\033[0K\r" && sleep 1;
done

# show database on irods-galera-2 is synchronized
echo "### show database on irods-galera-2 is synchronized ###"
CMD='ils -Lr /galeraZone/home/bob'
echo ${G2}" "${CMD}
docker exec irods-galera-2 gosu irods ${CMD}

# iget resource from newly spawned irods-galera-2
echo "### iget resource from newly spawned irods-galera-2 ###"
CMD='iget -f AAAAA.txt bob-AAAAA.txt'
echo ${BOB}" "${CMD}
docker run --rm -ti \
    -v ${REPO_DIR}/tests/files:/workspace \
    -e IRODS_HOST=172.18.0.4 \
    -e IRODS_PORT=1247 \
    -e IRODS_USER_NAME=bob \
    -e IRODS_ZONE_NAME=galeraZone \
    -e IRODS_PASSWORD=bob \
    --net galeranet \
    mjstealey/irods-icommands:latest ${CMD}

CMD='ls -alh'
echo ${BOB}" "${CMD}
ls -alh ${REPO_DIR}/tests/files | grep bob

exit 0;