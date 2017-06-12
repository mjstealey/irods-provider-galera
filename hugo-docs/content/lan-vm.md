+++
date = "2017-06-09T21:23:44-04:00"
description = "Local Area Network - Virtual Machines"
title = "LAN - virtual machines"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "lan-vm"
    parent = "poc"
    weight = 3

+++

Beyond the basic setup, a first round reasonable test to run would be the built in test located suite at `/var/lib/irods/scripts/run_tests.py` of every iRODS provider installation. The limitation of the test suite is that it wasn't necessarily designed to run against a clustered database, so the default notion of **demoResc** is problematic when the goal is to test across a distributed ICAT cluster. That said, we issued `python run_tests.py --run_python_suite` on each node within the cluster, one at a time.

![run_test.py]({{<baseurl>}}/images/runtests.png)

While the test suite runs on one node, the other nodes were monitored via various [iCommands](https://docs.irods.org/4.2.0/system_overview/glossary/#icommands) and SQL queries validating that the test files and corresponding database entires were being made as expected.

### run_tests.py

The `run_tests.py` script is the default script used for iRODS testing and is part of a normal iRODS installation. As a first round sanity check it was chosen to run with the `--run_python_suite` option which takes roughly 4 hours to complete all tests.

```console
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

### Running tests in docker

Since iRODS is being run in docker, it is necessary to invoke the test suite from within the docker container. This can be accomplished by connecting to the container as the **irods** user, changing to the appropriate directory, and issuing the test run call.

```console
$ docker exec -ti -u irods irods-galera-1 /bin/bash
bash-4.2$ cd ~
bash-4.2$ pwd
/var/lib/irods

bash-4.2$ ienv
irods_version - 4.2.1
irods_zone_name - tempZone
irods_host - galera-1.edc.renci.org
irods_user_name - rods
irods_transfer_buffer_size_for_parallel_transfer_in_megabytes - 4
schema_name - irods_environment
irods_server_control_plane_encryption_algorithm - AES-256-CBC
irods_match_hash_policy - compatible
irods_home - /tempZone/home/rods
irods_default_resource - demoResc
irods_encryption_num_hash_rounds - 16
schema_version - v3
irods_encryption_salt_size - 8
irods_encryption_algorithm - AES-256-CBC
irods_session_environment_file - /var/lib/irods/.irods/irods_environment.json.3460
irods_port - 1247
irods_maximum_size_for_single_buffer_in_megabytes - 32
irods_client_server_policy - CS_NEG_REFUSE
irods_environment_file - /var/lib/irods/.irods/irods_environment.json
irods_default_number_of_transfer_threads - 4
irods_default_hash_scheme - SHA256
irods_server_control_plane_encryption_num_hash_rounds - 16
irods_cwd - /tempZone/home/rods
irods_encryption_key_size - 32
irods_server_control_plane_port - 1248
irods_server_control_plane_key - TEMPORARY__32byte_ctrl_plane_key
irods_client_server_negotiation - request_server_negotiation

bash-4.2$ cd scripts/
bash-4.2$ python run_tests.py --run_python_suite
irods.test.test_xmsg.Test_Xmsg.test_send_and_receive_one_xmsg ... ok
irods.test.test_iadmin.Test_Iadmin.test_addchildtoresc_forbidden_characters_3449 ... ok
irods.test.test_iadmin.Test_Iadmin.test_admin_listings ... ok
irods.test.test_iadmin.Test_Iadmin.test_authentication_name ... ok
irods.test.test_iadmin.Test_Iadmin.test_create_and_remove_coordinating_resource ... ok
irods.test.test_iadmin.Test_Iadmin.test_create_and_remove_coordinating_resource_with_explicit_contextstring ... ok
...
```

The running tests can be observed from the other nodes via icommands or mysql queries.

Example: `ils ../` from galera-2.edc.renci.org

```console
[galera@galera-2 ~]$ docker exec -ti -u irods irods-galera-2 ils ../
/tempZone/home:
  C- /tempZone/home/alice
  C- /tempZone/home/bobby
  C- /tempZone/home/issue_3104_user
  C- /tempZone/home/otherrods
  C- /tempZone/home/public
  C- /tempZone/home/rods
```


Example: `ils -lr ../` from galera-3.edc.renci.org

```console
[galera@galera-3 ~]$ docker exec -ti -u irods irods-galera-3 ils -lr ../
/tempZone/home:
  C- /tempZone/home/alice
/tempZone/home/alice:
  C- /tempZone/home/alice/2017-06-11Z18:36:36--irods-testing-ST6GaS
/tempZone/home/alice/2017-06-11Z18:36:36--irods-testing-ST6GaS:
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 0.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 0.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 1.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 1.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 10.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 10.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 11.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 11.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 12.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 12.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 13.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 13.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 14.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 14.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 15.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 15.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 16.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 16.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 17.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 17.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 18.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 18.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 19.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 19.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 2.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 2.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 20.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 20.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 21.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 21.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 22.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 22.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 23.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 23.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 24.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 24.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 25.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 25.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 26.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 26.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 27.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 27.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 28.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 28.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 29.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 29.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 3.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 3.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 30.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 30.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 31.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 31.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 32.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 32.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 4.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 4.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 5.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 5.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 6.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 6.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 7.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 7.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 8.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 8.txt
  alice             0 demoResc;cacheResc            0 2017-06-11.18:36 & 9.txt
  alice             1 demoResc;archiveResc            0 2017-06-11.18:36 & 9.txt
  C- /tempZone/home/bobby
/tempZone/home/bobby:
  C- /tempZone/home/bobby/2017-06-11Z18:36:37--irods-testing-YZlZ5v
/tempZone/home/bobby/2017-06-11Z18:36:37--irods-testing-YZlZ5v:
  C- /tempZone/home/issue_3104_user
/tempZone/home/issue_3104_user:
  C- /tempZone/home/otherrods
/tempZone/home/otherrods:
  C- /tempZone/home/otherrods/2017-06-11Z18:36:36--irods-testing-hbOA7N
/tempZone/home/otherrods/2017-06-11Z18:36:36--irods-testing-hbOA7N:
  otherrods         0 demoResc;cacheResc           33 2017-06-11.18:36 & testfile.txt
  otherrods         1 demoResc;archiveResc           33 2017-06-11.18:36 & testfile.txt
  C- /tempZone/home/otherrods/2017-06-11Z18:36:36--irods-testing-hbOA7N/testdir
/tempZone/home/otherrods/2017-06-11Z18:36:36--irods-testing-hbOA7N/testdir:
  C- /tempZone/home/public
/tempZone/home/public:
  otherrods         0 demoResc;cacheResc           33 2017-06-11.18:36 & testfile.txt
  otherrods         1 demoResc;archiveResc           33 2017-06-11.18:36 & testfile.txt
  C- /tempZone/home/rods
/tempZone/home/rods:
```

{{% panel theme="success" header="PASSED" %}}
Result of running `python run_tests.py --run_python_suite`.

```console
bash-4.2$ python run_tests.py --run_python_suite
irods.test.test_xmsg.Test_Xmsg.test_send_and_receive_one_xmsg ... ok
irods.test.test_iadmin.Test_Iadmin.test_addchildtoresc_forbidden_characters_3449 ... ok
irods.test.test_iadmin.Test_Iadmin.test_admin_listings ... ok
irods.test.test_iadmin.Test_Iadmin.test_authentication_name ... ok
irods.test.test_iadmin.Test_Iadmin.test_create_and_remove_coordinating_resource ... ok
irods.test.test_iadmin.Test_Iadmin.test_create_and_remove_coordinating_resource_with_explicit_contextstring ... ok
...
irods.test.test_irmdir.Test_Irmdir.test_irmdir_of_collection_containing_dataobj ... ok
irods.test.test_irmdir.Test_Irmdir.test_irmdir_of_dataobj ... ok
irods.test.test_irmdir.Test_Irmdir.test_irmdir_of_empty_collection ... ok
irods.test.test_irmdir.Test_Irmdir.test_irmdir_of_nonexistent_collection ... ok
irods.test.test_iquest.Test_Iquest.test_iquest_MAX_SQL_ROWS_results__3262 ... ok

----------------------------------------------------------------------
Ran 1468 tests in 13106.840s

OK (skipped=89)
<__main__.RegisteredTestResult run=1468 errors=0 failures=0>
```
{{% /panel %}}

Full console log output available [here]({{<baseurl>}}/run-tests)
