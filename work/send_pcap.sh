#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 flavor"
	exit 1
fi
flavor=$1; shift
scp tcpdump*.pcap root@10.0.1.21:oselab/results/${flavor}/
