#!/bin/bash

function do_command {
	local cmd="$*"
	echo "=> ${cmd}"
	${cmd}
}

do_command ip -o l
do_command ip -d l
do_command ip -4 -o a
do_command ip -d a
do_command ip r

do_command ovs-vsctl show
do_command ovs-ofctl -O OpenFlow13 show br0
do_command ovs-ofctl -O OpenFlow13 dump-ports-desc br0
do_command ovs-ofctl -O OpenFlow13 dump-flows br0
do_command ovs-dpctl show
do_command ovs-dpctl dump-flows
do_command ovs-dpctl dump-flows -m
