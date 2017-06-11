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

While the test suite ran on one node, the other nodes were monitored via various [iCommands](https://docs.irods.org/4.2.0/system_overview/glossary/#icommands) and SQL queries validating that the test files and corresponding database entires were being made as expected.

### run_tests.py

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

Result of running `python run_tests.py --run_python_suite`.

```console
bash-4.2$ python run_tests.py --run_python_suite
irods.test.test_xmsg.Test_Xmsg.test_send_and_receive_one_xmsg ... ok
irods.test.test_iadmin.Test_Iadmin.test_admin_listings ... ok
irods.test.test_iadmin.Test_Iadmin.test_authentication_name ... ok
irods.test.test_iadmin.Test_Iadmin.test_create_and_remove_coordinating_resource ... ok
irods.test.test_iadmin.Test_Iadmin.test_create_and_remove_coordinating_resource_with_explicit_contextstring ... ok
...
irods.test.test_native_rule_engine_plugin.Test_Native_Rule_Engine_Plugin.test_out_variable ... ok
irods.test.test_native_rule_engine_plugin.Test_Native_Rule_Engine_Plugin.test_re_serialization ... ok
irods.test.test_native_rule_engine_plugin.Test_Native_Rule_Engine_Plugin.test_rule_engine_2242 ... ok
irods.test.test_native_rule_engine_plugin.Test_Native_Rule_Engine_Plugin.test_rule_engine_2309 ... ok

----------------------------------------------------------------------
Ran 1441 tests in 12162.759s

OK (skipped=89)
```

Full console log output available [here]({{<baseurl>}}/run-tests)
