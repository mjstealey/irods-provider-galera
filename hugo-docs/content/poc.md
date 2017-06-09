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

## Methods of testing

1. **[run_tests.py](https://github.com/irods/irods/blob/4-2-stable/scripts/run_tests.py)** on a single node

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

2. **[run_tests.py](https://github.com/irods/irods/blob/4-2-stable/scripts/run_tests.py)** on multiple nodes using **netem**

3. **[parallel_put_get.sh]({{<baseurl>}}/parallel_put_get)** on multiple nodes

4. **[parallel_put_get.sh]({{<baseurl>}}/parallel_put_get)** on multiple nodes using **netem**
