#!/bin/bash

#if [ x"$#" != x"1" ]; then
#	echo "$0 interface"
#	exit 1
#fi
#interface=$1; shift
#host=$(hostname -s)

host=$(hostname -s)

for interface in eth3 tun0 vxlan_sys_4789; do
	tcpdump -s 0 -w tcpdump-${host}-${interface}.pcap -i ${interface} &
	pid_${interface}=$!
done

trap "for int in eth3 tun0 vxlan_sys_4789; do kill -9 pid_${int}; done" INT
wait
