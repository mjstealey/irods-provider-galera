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

Running the irods-galera containers - assumes repository was checked out at `/home/$USER/irods-provider-galera`

```
$ docker run -d --name irods-galera1 -h irods-galera1 \
	-v /home/$USER/irods-provider-galera/init:/init \
	-e MYSQL_ROOT_PASSWORD=password \
	--env-file=env/galera1.env \
	--net galeranet \
	--ip 172.18.0.2 \
	--add-host irods-galera2:172.18.0.3 \
	--add-host irods-galera3:172.18.0.4 \
	irods-galera irods_setup.py --init
```