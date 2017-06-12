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
- galera-2.edc.renci.org: 60 ms
- galera-3.edc.renci.org: 120 ms

The parallel put/get scripts were again allowed to run against the nodes in this configuration for multiple hours.

![parallel iput / iget tests]({{<baseurl>}}/images/paralleltests.png)

## Setup

Based on the approximations for real-world latency NetEm was used to add delay to each node accordingly.

- Low nationally (RENCI/Chicago): 20ms
- Medium nationally (Coast to coast: RENCI/SF): 60ms
- International (Netherlands/RENCI): 117 ms

These values were implemented as follows:

- galera-1.edc.renci.org: `sudo tc qdisc add dev eth0 root netem delay 20.0ms`
- galera-2.edc.renci.org: `sudo tc qdisc add dev eth0 root netem delay 60.0ms`
- galera-3.edc.renci.org: `sudo tc qdisc add dev eth0 root netem delay 120.0ms`

Since NetEm effects both incoming and outgoing traffic, the effect was cumulative across nodes which can be observed in the RTT between nodes.

### RTT between nodes:

From galera-1.edc.renci.org:

```console
[galera@galera-1 ~]$ ping galera-2.edc.renci.org
PING galera-2.edc.renci.org (172.25.8.172) 56(84) bytes of data.
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=1 ttl=64 time=80.5 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=2 ttl=64 time=80.5 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=3 ttl=64 time=80.5 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=4 ttl=64 time=80.5 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=5 ttl=64 time=80.4 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=6 ttl=64 time=80.4 ms
^C
--- galera-2.edc.renci.org ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5007ms
rtt min/avg/max/mdev = 80.462/80.504/80.562/0.367 ms
[galera@galera-1 ~]$ ping galera-3.edc.renci.org
PING galera-3.edc.renci.org (172.25.8.173) 56(84) bytes of data.
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=1 ttl=64 time=140 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=2 ttl=64 time=140 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=3 ttl=64 time=140 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=4 ttl=64 time=140 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=5 ttl=64 time=140 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=6 ttl=64 time=140 ms
^C
--- galera-3.edc.renci.org ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5007ms
rtt min/avg/max/mdev = 140.422/140.513/140.618/0.437 ms
```

From galera-2.edc.renci.org:

```console
[galera@galera-2 ~]$ ping galera-1.edc.renci.org
PING galera-1.edc.renci.org (172.25.8.171) 56(84) bytes of data.
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=1 ttl=64 time=80.5 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=2 ttl=64 time=80.5 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=3 ttl=64 time=80.5 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=4 ttl=64 time=80.5 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=5 ttl=64 time=80.5 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=6 ttl=64 time=80.4 ms
^C
--- galera-1.edc.renci.org ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5007ms
rtt min/avg/max/mdev = 80.490/80.524/80.566/0.233 ms
[galera@galera-2 ~]$ ping galera-3.edc.renci.org
PING galera-3.edc.renci.org (172.25.8.173) 56(84) bytes of data.
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=1 ttl=64 time=180 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=2 ttl=64 time=180 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=3 ttl=64 time=180 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=4 ttl=64 time=180 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=5 ttl=64 time=180 ms
64 bytes from galera-3.edc.renci.org (172.25.8.173): icmp_seq=6 ttl=64 time=180 ms
^C
--- galera-3.edc.renci.org ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5006ms
rtt min/avg/max/mdev = 180.427/180.503/180.583/0.049 ms
```

From galera-3.edc.renci.org:

```console
[galera@galera-3 ~]$ ping galera-1.edc.renci.org
PING galera-1.edc.renci.org (172.25.8.171) 56(84) bytes of data.
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=1 ttl=64 time=140 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=2 ttl=64 time=140 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=3 ttl=64 time=140 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=4 ttl=64 time=140 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=5 ttl=64 time=140 ms
64 bytes from galera-1.edc.renci.org (172.25.8.171): icmp_seq=6 ttl=64 time=140 ms
^C
--- galera-1.edc.renci.org ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5007ms
rtt min/avg/max/mdev = 140.382/140.511/140.768/0.501 ms
[galera@galera-3 ~]$ ping galera-2.edc.renci.org
PING galera-2.edc.renci.org (172.25.8.172) 56(84) bytes of data.
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=1 ttl=64 time=180 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=2 ttl=64 time=180 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=3 ttl=64 time=180 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=4 ttl=64 time=180 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=5 ttl=64 time=180 ms
64 bytes from galera-2.edc.renci.org (172.25.8.172): icmp_seq=6 ttl=64 time=180 ms
^C
--- galera-2.edc.renci.org ping statistics ---
6 packets transmitted, 6 received, 0% packet loss, time 5001ms
rtt min/avg/max/mdev = 180.327/180.422/180.572/0.553 ms
```

## Parallel test

An additional three nodes were configured to run the latest version of iCommands and iinit to be the **rods** user on galera-1.edc.renci.org, galera-2.edc.renci.org and galera-3.edc.renci.org. Each node ran a copy of the [parallel_put_get.sh]({{<baseurl>}}/parallel-put-get.md) script modified to put files into **galera1Resc**, **galera2Resc**, and **galera3Resc** respectfully.

### What it does

The parallel_get_put.sh script was queued up and launched simultaneously on all three nodes. The scripts first generate 256 40 MB files and then start sending them via iput in 30 parallel threads. Once all 256 files have been transferred, they are then retrieved using iget in 30 parallel threads. This process is embedded in a loop and will continue until an error is encountered or is manually stopped.

### Output

Each loop outputs the time, put and get status to the console.

```console
$ time ./parallel_put_get.sh
Sun Jun 11 19:57:51 EDT 2017
Starting loop 1
 put
Academic tradition requires you to cite works you base your article on.
When using programs that use GNU Parallel to process data for publication
please cite:

  O. Tange (2011): GNU Parallel - The Command-Line Power Tool,
  ;login: The USENIX Magazine, February 2011:42-47.

This helps funding further development; AND IT WON'T COST YOU A CENT.
If you pay 10000 EUR you should feel free to use GNU Parallel without citing.

To silence the citation notice: run 'parallel --bibtex'.

 get
Academic tradition requires you to cite works you base your article on.
When using programs that use GNU Parallel to process data for publication
please cite:

  O. Tange (2011): GNU Parallel - The Command-Line Power Tool,
  ;login: The USENIX Magazine, February 2011:42-47.

This helps funding further development; AND IT WON'T COST YOU A CENT.
If you pay 10000 EUR you should feel free to use GNU Parallel without citing.

To silence the citation notice: run 'parallel --bibtex'.
...
```

Each loop of the script will generate and retrieve files named **bigfile.NNN** in a similar format to what is listed here:

```console
$ ls -R /var/galera/scratch_for_parallelputget/149722545913474/
/var/galera/scratch_for_parallelputget/149722545913474/:
benchmarks.coll  files.dir

/var/galera/scratch_for_parallelputget/149722545913474/benchmarks.coll:
bigfile.001  bigfile.027  bigfile.053  bigfile.079  bigfile.105  bigfile.131  bigfile.157  bigfile.183  bigfile.209  bigfile.235
bigfile.002  bigfile.028  bigfile.054  bigfile.080  bigfile.106  bigfile.132  bigfile.158  bigfile.184  bigfile.210  bigfile.236
bigfile.003  bigfile.029  bigfile.055  bigfile.081  bigfile.107  bigfile.133  bigfile.159  bigfile.185  bigfile.211  bigfile.237
bigfile.004  bigfile.030  bigfile.056  bigfile.082  bigfile.108  bigfile.134  bigfile.160  bigfile.186  bigfile.212  bigfile.238
bigfile.005  bigfile.031  bigfile.057  bigfile.083  bigfile.109  bigfile.135  bigfile.161  bigfile.187  bigfile.213  bigfile.239
bigfile.006  bigfile.032  bigfile.058  bigfile.084  bigfile.110  bigfile.136  bigfile.162  bigfile.188  bigfile.214  bigfile.240
bigfile.007  bigfile.033  bigfile.059  bigfile.085  bigfile.111  bigfile.137  bigfile.163  bigfile.189  bigfile.215  bigfile.241
bigfile.008  bigfile.034  bigfile.060  bigfile.086  bigfile.112  bigfile.138  bigfile.164  bigfile.190  bigfile.216  bigfile.242
bigfile.009  bigfile.035  bigfile.061  bigfile.087  bigfile.113  bigfile.139  bigfile.165  bigfile.191  bigfile.217  bigfile.243
bigfile.010  bigfile.036  bigfile.062  bigfile.088  bigfile.114  bigfile.140  bigfile.166  bigfile.192  bigfile.218  bigfile.244
bigfile.011  bigfile.037  bigfile.063  bigfile.089  bigfile.115  bigfile.141  bigfile.167  bigfile.193  bigfile.219  bigfile.245
bigfile.012  bigfile.038  bigfile.064  bigfile.090  bigfile.116  bigfile.142  bigfile.168  bigfile.194  bigfile.220  bigfile.246
bigfile.013  bigfile.039  bigfile.065  bigfile.091  bigfile.117  bigfile.143  bigfile.169  bigfile.195  bigfile.221  bigfile.247
bigfile.014  bigfile.040  bigfile.066  bigfile.092  bigfile.118  bigfile.144  bigfile.170  bigfile.196  bigfile.222  bigfile.248
bigfile.015  bigfile.041  bigfile.067  bigfile.093  bigfile.119  bigfile.145  bigfile.171  bigfile.197  bigfile.223  bigfile.249
bigfile.016  bigfile.042  bigfile.068  bigfile.094  bigfile.120  bigfile.146  bigfile.172  bigfile.198  bigfile.224  bigfile.250
bigfile.017  bigfile.043  bigfile.069  bigfile.095  bigfile.121  bigfile.147  bigfile.173  bigfile.199  bigfile.225  bigfile.251
bigfile.018  bigfile.044  bigfile.070  bigfile.096  bigfile.122  bigfile.148  bigfile.174  bigfile.200  bigfile.226  bigfile.252
bigfile.019  bigfile.045  bigfile.071  bigfile.097  bigfile.123  bigfile.149  bigfile.175  bigfile.201  bigfile.227  bigfile.253
bigfile.020  bigfile.046  bigfile.072  bigfile.098  bigfile.124  bigfile.150  bigfile.176  bigfile.202  bigfile.228  bigfile.254
bigfile.021  bigfile.047  bigfile.073  bigfile.099  bigfile.125  bigfile.151  bigfile.177  bigfile.203  bigfile.229  bigfile.255
bigfile.022  bigfile.048  bigfile.074  bigfile.100  bigfile.126  bigfile.152  bigfile.178  bigfile.204  bigfile.230  bigfile.256
bigfile.023  bigfile.049  bigfile.075  bigfile.101  bigfile.127  bigfile.153  bigfile.179  bigfile.205  bigfile.231  iget-all
bigfile.024  bigfile.050  bigfile.076  bigfile.102  bigfile.128  bigfile.154  bigfile.180  bigfile.206  bigfile.232  iput-all
bigfile.025  bigfile.051  bigfile.077  bigfile.103  bigfile.129  bigfile.155  bigfile.181  bigfile.207  bigfile.233
bigfile.026  bigfile.052  bigfile.078  bigfile.104  bigfile.130  bigfile.156  bigfile.182  bigfile.208  bigfile.234

/var/galera/scratch_for_parallelputget/149722545913474/files.dir:
bigfile.001  bigfile.027  bigfile.053  bigfile.079  bigfile.105  bigfile.131  bigfile.157  bigfile.183  bigfile.209  bigfile.235
bigfile.002  bigfile.028  bigfile.054  bigfile.080  bigfile.106  bigfile.132  bigfile.158  bigfile.184  bigfile.210  bigfile.236
bigfile.003  bigfile.029  bigfile.055  bigfile.081  bigfile.107  bigfile.133  bigfile.159  bigfile.185  bigfile.211  bigfile.237
bigfile.004  bigfile.030  bigfile.056  bigfile.082  bigfile.108  bigfile.134  bigfile.160  bigfile.186  bigfile.212  bigfile.238
bigfile.005  bigfile.031  bigfile.057  bigfile.083  bigfile.109  bigfile.135  bigfile.161  bigfile.187  bigfile.213  bigfile.239
bigfile.006  bigfile.032  bigfile.058  bigfile.084  bigfile.110  bigfile.136  bigfile.162  bigfile.188  bigfile.214  bigfile.240
bigfile.007  bigfile.033  bigfile.059  bigfile.085  bigfile.111  bigfile.137  bigfile.163  bigfile.189  bigfile.215  bigfile.241
bigfile.008  bigfile.034  bigfile.060  bigfile.086  bigfile.112  bigfile.138  bigfile.164  bigfile.190  bigfile.216  bigfile.242
bigfile.009  bigfile.035  bigfile.061  bigfile.087  bigfile.113  bigfile.139  bigfile.165  bigfile.191  bigfile.217  bigfile.243
bigfile.010  bigfile.036  bigfile.062  bigfile.088  bigfile.114  bigfile.140  bigfile.166  bigfile.192  bigfile.218  bigfile.244
bigfile.011  bigfile.037  bigfile.063  bigfile.089  bigfile.115  bigfile.141  bigfile.167  bigfile.193  bigfile.219  bigfile.245
bigfile.012  bigfile.038  bigfile.064  bigfile.090  bigfile.116  bigfile.142  bigfile.168  bigfile.194  bigfile.220  bigfile.246
bigfile.013  bigfile.039  bigfile.065  bigfile.091  bigfile.117  bigfile.143  bigfile.169  bigfile.195  bigfile.221  bigfile.247
bigfile.014  bigfile.040  bigfile.066  bigfile.092  bigfile.118  bigfile.144  bigfile.170  bigfile.196  bigfile.222  bigfile.248
bigfile.015  bigfile.041  bigfile.067  bigfile.093  bigfile.119  bigfile.145  bigfile.171  bigfile.197  bigfile.223  bigfile.249
bigfile.016  bigfile.042  bigfile.068  bigfile.094  bigfile.120  bigfile.146  bigfile.172  bigfile.198  bigfile.224  bigfile.250
bigfile.017  bigfile.043  bigfile.069  bigfile.095  bigfile.121  bigfile.147  bigfile.173  bigfile.199  bigfile.225  bigfile.251
bigfile.018  bigfile.044  bigfile.070  bigfile.096  bigfile.122  bigfile.148  bigfile.174  bigfile.200  bigfile.226  bigfile.252
bigfile.019  bigfile.045  bigfile.071  bigfile.097  bigfile.123  bigfile.149  bigfile.175  bigfile.201  bigfile.227  bigfile.253
bigfile.020  bigfile.046  bigfile.072  bigfile.098  bigfile.124  bigfile.150  bigfile.176  bigfile.202  bigfile.228  bigfile.254
bigfile.021  bigfile.047  bigfile.073  bigfile.099  bigfile.125  bigfile.151  bigfile.177  bigfile.203  bigfile.229  bigfile.255
bigfile.022  bigfile.048  bigfile.074  bigfile.100  bigfile.126  bigfile.152  bigfile.178  bigfile.204  bigfile.230  bigfile.256
bigfile.023  bigfile.049  bigfile.075  bigfile.101  bigfile.127  bigfile.153  bigfile.179  bigfile.205  bigfile.231
bigfile.024  bigfile.050  bigfile.076  bigfile.102  bigfile.128  bigfile.154  bigfile.180  bigfile.206  bigfile.232
bigfile.025  bigfile.051  bigfile.077  bigfile.103  bigfile.129  bigfile.155  bigfile.181  bigfile.207  bigfile.233
bigfile.026  bigfile.052  bigfile.078  bigfile.104  bigfile.130  bigfile.156  bigfile.182  bigfile.208  bigfile.234
```

The iRODS registration of the files can be seen in the [ils - parallel put get]({{<baseurl>}}/ils) example file.

The test files as iput into iRODS can be found in the corresponding vault directory of the corresponding iRODS provider Galera node.

```console
$ ls /var/galera/vault/home/rods/scratch_for_parallelputget/149722545913474/benchmarks.coll/
bigfile.001  bigfile.027  bigfile.053  bigfile.079  bigfile.105  bigfile.131  bigfile.157  bigfile.183  bigfile.209  bigfile.235
bigfile.002  bigfile.028  bigfile.054  bigfile.080  bigfile.106  bigfile.132  bigfile.158  bigfile.184  bigfile.210  bigfile.236
bigfile.003  bigfile.029  bigfile.055  bigfile.081  bigfile.107  bigfile.133  bigfile.159  bigfile.185  bigfile.211  bigfile.237
bigfile.004  bigfile.030  bigfile.056  bigfile.082  bigfile.108  bigfile.134  bigfile.160  bigfile.186  bigfile.212  bigfile.238
bigfile.005  bigfile.031  bigfile.057  bigfile.083  bigfile.109  bigfile.135  bigfile.161  bigfile.187  bigfile.213  bigfile.239
bigfile.006  bigfile.032  bigfile.058  bigfile.084  bigfile.110  bigfile.136  bigfile.162  bigfile.188  bigfile.214  bigfile.240
bigfile.007  bigfile.033  bigfile.059  bigfile.085  bigfile.111  bigfile.137  bigfile.163  bigfile.189  bigfile.215  bigfile.241
bigfile.008  bigfile.034  bigfile.060  bigfile.086  bigfile.112  bigfile.138  bigfile.164  bigfile.190  bigfile.216  bigfile.242
bigfile.009  bigfile.035  bigfile.061  bigfile.087  bigfile.113  bigfile.139  bigfile.165  bigfile.191  bigfile.217  bigfile.243
bigfile.010  bigfile.036  bigfile.062  bigfile.088  bigfile.114  bigfile.140  bigfile.166  bigfile.192  bigfile.218  bigfile.244
bigfile.011  bigfile.037  bigfile.063  bigfile.089  bigfile.115  bigfile.141  bigfile.167  bigfile.193  bigfile.219  bigfile.245
bigfile.012  bigfile.038  bigfile.064  bigfile.090  bigfile.116  bigfile.142  bigfile.168  bigfile.194  bigfile.220  bigfile.246
bigfile.013  bigfile.039  bigfile.065  bigfile.091  bigfile.117  bigfile.143  bigfile.169  bigfile.195  bigfile.221  bigfile.247
bigfile.014  bigfile.040  bigfile.066  bigfile.092  bigfile.118  bigfile.144  bigfile.170  bigfile.196  bigfile.222  bigfile.248
bigfile.015  bigfile.041  bigfile.067  bigfile.093  bigfile.119  bigfile.145  bigfile.171  bigfile.197  bigfile.223  bigfile.249
bigfile.016  bigfile.042  bigfile.068  bigfile.094  bigfile.120  bigfile.146  bigfile.172  bigfile.198  bigfile.224  bigfile.250
bigfile.017  bigfile.043  bigfile.069  bigfile.095  bigfile.121  bigfile.147  bigfile.173  bigfile.199  bigfile.225  bigfile.251
bigfile.018  bigfile.044  bigfile.070  bigfile.096  bigfile.122  bigfile.148  bigfile.174  bigfile.200  bigfile.226  bigfile.252
bigfile.019  bigfile.045  bigfile.071  bigfile.097  bigfile.123  bigfile.149  bigfile.175  bigfile.201  bigfile.227  bigfile.253
bigfile.020  bigfile.046  bigfile.072  bigfile.098  bigfile.124  bigfile.150  bigfile.176  bigfile.202  bigfile.228  bigfile.254
bigfile.021  bigfile.047  bigfile.073  bigfile.099  bigfile.125  bigfile.151  bigfile.177  bigfile.203  bigfile.229  bigfile.255
bigfile.022  bigfile.048  bigfile.074  bigfile.100  bigfile.126  bigfile.152  bigfile.178  bigfile.204  bigfile.230  bigfile.256
bigfile.023  bigfile.049  bigfile.075  bigfile.101  bigfile.127  bigfile.153  bigfile.179  bigfile.205  bigfile.231
bigfile.024  bigfile.050  bigfile.076  bigfile.102  bigfile.128  bigfile.154  bigfile.180  bigfile.206  bigfile.232
bigfile.025  bigfile.051  bigfile.077  bigfile.103  bigfile.129  bigfile.155  bigfile.181  bigfile.207  bigfile.233
bigfile.026  bigfile.052  bigfile.078  bigfile.104  bigfile.130  bigfile.156  bigfile.182  bigfile.208  bigfile.234
```

{{% panel theme="success" header="PASSED" %}}

The three nodes ran without error until manually interrupted and forcibly quit.

```console
real	132m54.348s
user	5m56.958s
sys	2m15.345s
```

During this period each node completed:

- galera-1.edc.renci.org: **48 loops** (20 ms latency via NetEm)
- galera-2.edc.renci.org: **12 loops** (60 ms latency via NetEm)
- galera-3.edc.renci.org: **3 loops** (120 ms latency via NetEm)

{{% /panel %}}
