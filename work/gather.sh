#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 flavor"
	exit 1
fi
flavor=$1; shift
logdir=~/oselab/results

for node in infra1 node1 node2; do
	scp ${node}:${logdir}/${flavor}/* ${logdir}/${flavor}/
done
