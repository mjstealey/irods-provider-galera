+++
date = "2017-06-10T21:07:48-04:00"
description = "Code / Console / Log output"
title = "Code / Console log"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "code"
    parent = "poc"
    weight = 10

+++

**[default_init.log]({{<baseurl>}}/init)**: Resultant output from running the irods-provider-galera container with default settings

**[run_tests.log]({{<baseurl>}}/run-tests)**: Console output from running `python run_tests.py --run_python_suite`

**[parallel_put_get.sh]({{<baseurl>}}/parallel-put-get)**: Parallel iput / iget script used for testing all nodes simultaneously

**[init_galera.log]({{<baseurl>}}/init-galera)**: Resultant output from running `./init-galera && docker attach --sig-proxy=false irods-galera-1` in the testbed

**[ils - parallel put get]({{<baseurl>}}/ils)**: Contents of `ils -lr` while running parallel tests from one of the testbed nodes
