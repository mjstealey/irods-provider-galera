+++
date = "2017-06-09T21:23:52-04:00"
description = "Wide Area Network - Virtual Machines"
title = "WAN - virtual machines"

creatordisplayname = "Michael J. Stealey" creatoremail = "michael.j.stealey@gmail.com" lastmodifierdisplayname = "Michael J. Stealey" lastmodifieremail = "michael.j.stealey@gmail.com"

[menu]

  [menu.main]
    identifier = "wan-vm"
    parent = "poc"
    weight = 4

+++

## Design

The testbed nodes were configured as described in the [Galera VMs]({{<baseurl>}}/galera-vms#design) section. The parallel put/get test was first run on the testbed without any additional latency introduced to the nodes and allowed to run for 6 hours. The next test involved introducing varying amounts of latency to each node using NetEm. The latency values were set as follows.

- galera-1.edc.renci.org: 20 ms
- galera-2.edc.renci.org: 120 ms
- galera-3.edc.renci.org: 150 ms

The parellel put/get scripts were again allowed to run against the nodes in this configuration for 6 hours.

![parallel iput / iget tests]({{<baseurl>}}/images/paralleltests.png)
