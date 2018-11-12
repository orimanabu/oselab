#!/bin/bash

ovsutil=${HOME}/setup_openshift/bin/ovsutil

if [ x"$#" != x"1" ]; then
	echo "$0 host"
	exit 1
fi
host=$1; shift

echo "=> ovs-vsctl show"
${ovsutil} ${host} ovs-vsctl show

echo "=> ovs-ofctl -O OpenFlow13 show br0"
${ovsutil} ${host} ovs-ofctl -O OpenFlow13 show br0

echo "=> ovs-ofctl -O OpenFlow13 dump-ports-desc br0"
${ovsutil} ${host} ovs-ofctl -O OpenFlow13 dump-ports-desc br0

echo "=> ovs-ofctl -O OpenFlow13 dump-flows br0"
${ovsutil} ${host} ovs-ofctl -O OpenFlow13 dump-flows br0 | sed -r -e 's/duration=[0-9.s]+, //' -e 's/n_packets=[0-9]+, //' -e 's/n_bytes=[0-9]+, //'

echo "=> ovs-dpctl show"
${ovsutil} ${host} ovs-dpctl show

echo "=> ovs-dpctl dump-flows"
${ovsutil} ${host} ovs-dpctl dump-flows

echo "=> ovs-dpctl dump-flows -m"
${ovsutil} ${host} ovs-dpctl dump-flows -m
