# Vagrant virtualbox multicast network test fixture

This project includes vagrant/virtualbox setup code designed to create a cluster
of virtual machines capabile of transmitting multicast traffic across a private
internal network. With this setup, it is possible to perform iperf and other
multicast related testing.

### Prerequisites

* Install virtualbox, vagrant, and git on your local system.

### Installing

```console
$ git clone https://github.com/kbsheets/vagrant_multicast.git
$ cd vagrant_multicast
$ vi Vagrantfile # Edit VM count and other relevant parameters to taste
$ vagrant up
```

When vagrant completes, you will have a cluster of nodes with public
and private network interfaces. The nodes will have iperf installed to
allow testing of various multicast communication scenarios.

For example:

Node 2 (server)

```console
$ vagrant ssh node-2
[vagrant@node-2 ~]$ iperf -s -B 239.255.1.3 -u -f m -i 1
------------------------------------------------------------
Server listening on UDP port 5001
Binding to local address 239.255.1.3
Joining multicast group  239.255.1.3
Receiving 1470 byte datagrams
UDP buffer size: 0.20 MByte (default)
------------------------------------------------------------
[  3] local 239.255.1.3 port 5001 connected with 192.168.2.11 port 57541
[ ID] Interval       Transfer     Bandwidth        Jitter   Lost/Total Datagrams
[  3]  0.0- 1.0 sec  0.13 MBytes  1.05 Mbits/sec   0.269 ms    0/  257 (0%)
[  3]  1.0- 2.0 sec  0.12 MBytes  1.05 Mbits/sec   0.183 ms    0/  256 (0%)
[  3]  2.0- 3.0 sec  0.12 MBytes  1.05 Mbits/sec   0.237 ms    0/  256 (0%)
[  3]  3.0- 4.0 sec  0.13 MBytes  1.05 Mbits/sec   0.322 ms    0/  257 (0%)
[  3]  4.0- 5.0 sec  0.12 MBytes  1.04 Mbits/sec   0.146 ms    0/  255 (0%)
[  3]  5.0- 6.0 sec  0.12 MBytes  1.04 Mbits/sec   0.150 ms    0/  255 (0%)
[  3]  6.0- 7.0 sec  0.12 MBytes  1.05 Mbits/sec   0.164 ms    0/  256 (0%)
[  3]  7.0- 8.0 sec  0.13 MBytes  1.06 Mbits/sec   0.222 ms    0/  258 (0%)
[  3]  8.0- 9.0 sec  0.12 MBytes  1.04 Mbits/sec   0.145 ms    0/  254 (0%)
[  3]  9.0-10.0 sec  0.13 MBytes  1.05 Mbits/sec   0.220 ms    0/  257 (0%)
[  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec   0.220 ms    0/ 2561 (0%)
```

Node 1 (client)

```console
$ vagrant ssh node-1
[vagrant@node-1 ~]$ iperf -c 239.255.1.3 -u -l 512 -T 30
------------------------------------------------------------
Client connecting to 239.255.1.3, UDP port 5001
Sending 512 byte datagrams, IPG target: 3906.25 us (kalman adjust)
Setting multicast TTL to 30
UDP buffer size:  208 KByte (default)
------------------------------------------------------------
[  3] local 192.168.2.11 port 57541 connected with 239.255.1.3 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-10.0 sec  1.25 MBytes  1.05 Mbits/sec
[  3] Sent 2561 datagrams
[vagrant@node-1 ~]$
```

## Authors

* **Kitrick Sheets** - *Initial work* - [kbsheets](https://github.com/kbsheets)

## License

This project is licensed under the Apache License, Version 2.0 - see the [apache-license-2.0.md](apache-license-2.0.md) file for details

## Acknowledgments

This code is an automation of techniques and approaches from various net sources

  * Including:
    * https://jupfaf.net/index.php?article10/multicast-between-virtual-machines-in-virtualbox
    * http://troglobit.com/howto/multicast/
    * https://www.ibm.com/support/knowledgecenter/en/SSQPD3_2.6.0/com.ibm.wllm.doc/runningiperfmulti.html

   Many thanks to the authors of these articles.
