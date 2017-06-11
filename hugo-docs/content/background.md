+++
date = "2017-05-27T20:33:02-04:00"
description = "Background"
title = "Background"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "background"
    parent = ""
    weight = 1

+++

## Why use MariaDB Galera cluster to service the iRODS catalog provider?

An iRODS use case was presented where geographically disparate participants wanted to belong to the same iRODS Zone for ease of search and discovery, but also wanted all nodes to be provider nodes with their own catalog. There was a desire to be able to decentralize the normally singular ICAT catalog database in a way that all participants could make use of whichever ICAT provider was closest to them without having to federate iRODS zones if new nodes came online.

Initial requirements:

- Every iRODS provider node would contain the ICAT catalog and local storage space that could be uniquely assigned to that node as a resource
- Files would be transferred to the iRODS provider node deemed closest to the point of file origination with respect to network latency and disk I/O metrics
- All nodes must pass some sort of quality assurance test beyond the standard iRODS test suite which only exercises a single node via the demoResc resource

The proof of concept solution being presented here uses MariaDB configured as a Galera cluster to decentralize the ICAT catalog database across all participating iRODS provider nodes.

WAN replication will use ample latency values commensurate for an international WAN deployment.

- Low nationally (RENCI/Chicago): 20ms
- Medium nationally (Coast to coast: RENCI/SF): 60ms
- International (Netherlands/RENCI):117 ms
- International (Sydney/Netherlands): 300 ms
- International (Sydney/RENCI): 210ms

A proof of concept testbed comprised of three iRODS provider nodes has been stood up to form a single zone named **tempZone** within a MariaDB Galera cluster. Each node within the testbed is a single CentOS 7 VM, and can be configured to use differing latency values via [NetEm](http://man7.org/linux/man-pages/man8/tc-netem.8.html) to simulate the kind of network traffic that would be experienced in a WAN configuration.

![Galera testbed]({{<baseurl>}}/images/galeratestbed.png)


## References

### iRODS

**What is iRODS**: The Integrated Rule-Oriented Data System (iRODS) is open source data management software used by research organizations and government agencies worldwide.

iRODS is released as a production-level distribution aimed at deployment in mission critical environments. It virtualizes data storage resources, so users can take control of their data, regardless of where and on what device the data is stored.

The development infrastructure supports exhaustive testing on supported platforms.

The plugin architecture supports microservices, storage systems, authentication, networking, databases, rule engines, and an extensible API.

Learn more at: [irods.org](https://irods.org)

### MariaDB

**Why MariaDB**: MariaDB is an open source leader, collaborating with innovators like Alibaba, Google and Facebook to develop and incorporate new features and improvements for the whole community, while at the same time helping customers like DBS Bank standardize on MariaDB solutions – ensuring enterprise and architecture requirements are met, now and in the future.

Learn more at: [mariadb.com](https://mariadb.com)

### Galera cluster

**What is MariaDB Galera cluster?**

**About**

MariaDB Galera Cluster is a synchronous multi-master cluster for MariaDB. It is available on Linux only, and only supports the [XtraDB/InnoDB](https://mariadb.com/kb/en/xtradb-and-innodb/) storage engines (although there is experimental support for [MyISAM](https://mariadb.com/kb/en/myisam/) - see the [wsrep_replicate_myisam](https://mariadb.com/kb/en/galera-cluster-system-variables/#wsrep_replicate_myisam) system variable).

Starting with [MariaDB 10.1](https://mariadb.com/kb/en/what-is-mariadb-101/), the wsrep API for Galera Cluster is included by default. This is available as a separate download for [MariaDB 10.0](https://mariadb.com/kb/en/what-is-mariadb-100/) and [MariaDB 5.5](https://mariadb.com/kb/en/what-is-mariadb-55/).

**Features**

- Synchronous replication
- Active-active multi-master topology
- Read and write to any cluster node
- Automatic membership control, failed nodes drop from the cluster
- Automatic node joining
- True parallel replication, on row level
- Direct client connections, native MariaDB look & feel

**Benefits**

The above features yield several benefits for a DBMS clustering solution, including:

- No slave lag
- No lost transactions
- Both read and write scalability
- Smaller client latencies

The [Getting Started with MariaDB Galera Cluster](https://mariadb.com/kb/en/getting-started-with-mariadb-galera-cluster/) page has instructions on how to get up and running with MariaDB Galera Cluster.

Learn more at: [what-is-mariadb-galera-cluster](https://mariadb.com/kb/en/mariadb/what-is-mariadb-galera-cluster/)
