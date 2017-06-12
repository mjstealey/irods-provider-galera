+++
date = "2017-05-27T20:23:40-04:00"
description = "Usage"
title = "Usage"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "usage"
    parent = ""
    weight = 2

+++

iRODS provider using MariaDB Galera cluster in Docker is based on: [mjstealey/mariadb-galera](https://github.com/mjstealey/mariadb-galera) from [centos:7](https://hub.docker.com/_/centos/)

## Supported iRODS versions

Supported tags in [docker hub](https://hub.docker.com/r/mjstealey/irods-provider-galera/) with respective Dockerfile link:

- 4.2.1, latest ([4.2.1/Dockerfile](https://github.com/mjstealey/irods-provider-galera/blob/master/4.2.1/Dockerfile))
- 4.2.0 ([4.2.0/Dockerfile](https://github.com/mjstealey/irods-provider-galera/blob/master/4.2.0/Dockerfile))

### Pull image from dockerhub

Reference: [mjstealey/irods-provider-galera/](https://hub.docker.com/r/mjstealey/irods-provider-galera/)

```bash
docker pull mjstealey/irods-provider-galera:latest
```

### Building locally

```
$ git clone https://github.com/mjstealey/irods-provider-galera.git
$ cd irods-provider-galera/4.2.1/
$ docker build -t irods-provider-galera .
```

### Usage options

Show brief help

```console
$ docker run --rm mjstealey/irods-provider-galera:4.2.1 -h
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
```

Initialize single node with default settings

```console
$ docker run -d mjstealey/irods-provider-galera:4.2.1 -iv setup_irods.py
a9890f386ece5f44648a66ea352a3142bcf39aac4455865e1387cbd3ac937945
```

Because the container was launched with the `-d` flag, it will be daemonized. The output can be viewed by looking at the log of the named container. The container name will be a random two part string separated by "\_" if not defined in the docker run command. In this example it is **adoring\_lamport**

```console
$ docker ps -a
CONTAINER ID        IMAGE                                   COMMAND                  CREATED              STATUS              PORTS                                                               NAMES
a9890f386ece        mjstealey/irods-provider-galera:4.2.1   "/docker-entrypoin..."   About a minute ago   Up About a minute   1247-1248/tcp, 3306/tcp, 4444/tcp, 4567-4568/tcp, 20000-20199/tcp   adoring_lamport
...
```
