#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 interface"
	exit 1
fi
interface=$1; shift
host=$(hostname -s)
tcpdump -v -w tcpdump-${host}-${interface}.pcap -U -T vxlan -nni ${interface} not port ssh
