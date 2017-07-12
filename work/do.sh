#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 flavor"
	exit 1
fi
flavor=$1; shift

self=$(hostname -s)
logdir=../results/${flavor}
bindir=../bin

mkdir -p ${logdir}
hostname | grep master && ${bindir}/ose_info.sh master > ${logdir}/oc
hostname | grep master && ${bindir}/etcdctl.sh 2> /dev/null > ${logdir}/etcd
hostname | grep master && ${bindir}/ose_router.sh > ${logdir}/router
${bindir}/ose_iptables.sh > ${logdir}/iptables-${self}
${bindir}/ose_network.sh > ${logdir}/network-${self}
${bindir}/ose_ovs.sh > ${logdir}/flow-${self}
