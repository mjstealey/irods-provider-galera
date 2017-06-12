+++
date = "2017-05-27T20:33:21-04:00"
description = "Proof of concept"
title = "Proof of concept"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "poc"
    parent = ""
    weight = 3

+++

## Testbed Deployment

Three CentOS 7.3.1611 (Core) virtual machines (VMs) were stood up to establish an iRODS provider Galera cluster testbed. Each VM is configured with a user account named **galera** which has rights to run Docker and not much else. [Complete testbed information]({{<baseurl>}}/galera-vms)

![Galera testbed]({{<baseurl>}}/images/galeratestbed.png)

## Testing methods

A series of tests were applied to the nodes with differing requirements and complexity. Initially the nodes were tested in a known local environment for debugging purposes. From there, the standard iRODS test suite was applied to the whole testbed, one node at a time. Finally all nodes were subject to 30 parallel streams of iput and iget statements for 256 40 MB files concurrently while being configured to replicate varying degrees of latency using NetEm.

### LAN

1. **[LAN - local machine]({{<baseurl>}}/lan-local)**:  The [three-node-test.sh](https://github.com/mjstealey/irods-provider-galera/blob/master/three-node-test.sh) run on single node using docker network

2. **[LAN - virtual machines]({{<baseurl>}}/lan-vm)**: The [run_tests.py](https://github.com/irods/irods/blob/4-2-stable/scripts/run_tests.py) script run on a single node at a time

    Every installation of iRODS includes a python script that will run various tests located at `/var/lib/irods/scripts/run_tests.py`

    ```bash
    $ python run_tests.py --help
    Usage: run_tests.py [options]

    Options:
      -h, --help            show this help message and exit
      --run_specific_test=dotted name
      --run_python_suite
      --include_auth_tests
      --run_devtesty
      --topology_test=<icat|resource>
      --catch_keyboard_interrupt
      --use_ssl
      --no_buffer
      --xml_output
      --federation=<remote irods version, remote zone, remote host>
    ```

### WAN

3. **[WAN - virtual machines]({{<baseurl>}}/wan-vm)**: The [parallel_put_get.sh]({{<baseurl>}}/parallel-put-get) script run on every node concurrently using **NetEm** to vary latency per node
