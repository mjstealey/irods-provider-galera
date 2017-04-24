# irods-provider-galera

**WORK IN PROGRESS**

iRODS provider that has the iCAT database back-ended by MariaDB Galera cluster in Docker

Based on: [mjstealey/mariadb-galera](https://github.com/mjstealey/mariadb-galera) using [centos:7](https://hub.docker.com/_/centos/)

### Building

```
$ git clone https://github.com/mjstealey/irods-provider-galera.git
$ cd irods-provider-galera/4.2.0/
$ docker build -t irods-galera .
```


### Usage:

Create local network

```
$ docker network create --subnet=172.18.0.0/16 galeranet
```

Running the irods-galera containers - assumes repository was checked out to location `${REPO_DIR}`

```
$ docker run -d --name irods-galera-1 -h irods-galera-1 \
    -v ${REPO_DIR}/init:/init \
    -e MYSQL_ROOT_PASSWORD=password \
    --env-file=env/irods-galera-1.env \
    --net galeranet \
    --ip 172.18.0.2 \
    --add-host irods-galera-2:172.18.0.3 \
    --add-host irods-galera-3:172.18.0.4 \
    irods-galera setup_irods.py --init

$ docker run -d --name irods-galera-2 -h irods-galera-2 \
    -v ${REPO_DIR}/init:/init \
    -e MYSQL_ROOT_PASSWORD=password \
    --env-file=env/irods-galera-2.env \
    --net galeranet \
    --ip 172.18.0.3 \
    --add-host irods-galera-1:172.18.0.2 \
    --add-host irods-galera-3:172.18.0.4 \
    irods-galera setup_irods.py --init

$ docker run -d --name irods-galera-3 -h irods-galera-3 \
    -v ${REPO_DIR}/init:/init \
    -e MYSQL_ROOT_PASSWORD=password \
    --env-file=env/irods-galera-3.env \
    --net galeranet \
    --ip 172.18.0.4 \
    --add-host irods-galera-1:172.18.0.2 \
    --add-host irods-galera-2:172.18.0.3 \
    irods-galera setup_irods.py --init
```