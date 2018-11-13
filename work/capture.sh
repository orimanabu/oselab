#!/bin/bash

#if [ x"$#" != x"1" ]; then
#	echo "$0 int"
#	exit 1
#fi
#int=$1; shift
#host=$(hostname -s)

host=$(hostname -s)

tcpdump -s 0 -w tcpdump-${host}-eth3.pcap -i eth3 &
pid_eth3=$!
tcpdump -s 0 -w tcpdump-${host}-tun0 -i tun0 &
pid_tun0=$!
tcpdump -s 0 -w tcpdump-${host}-vxlan_sys_4789.pcap -i vxlan_sys_4789 &
pid_vxlan_sys_4789=$!

trap "kill -9 pid_eth3; kill -9 pid_tun0; kill -9 pid_vxlan_sys_4789" INT
wait
