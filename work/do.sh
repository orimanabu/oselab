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
echo "=> info"
hostname | grep master && ${bindir}/ose_info.sh master > ${logdir}/oc
#echo "=> etcd"
#hostname | grep master && ${bindir}/etcdctl.sh 2> /dev/null > ${logdir}/etcd
echo "=> router"
hostname | grep master && ${bindir}/ose_router.sh > ${logdir}/router
for node in ocp311-master1 ocp311-infra1 ocp311-node1 ocp311-node2; do
	echo "=> ovs ${node}"
	hostname | grep master > /dev/null 2>&1 && ${bindir}/ose_ovs.sh ${node} > ${logdir}/flow-${node}
	echo "=> iptables ${node}"
	ssh ${node} /root/oselab/bin/ose_iptables.sh > ${logdir}/iptables-${node}
	echo "=> network ${node}"
	ssh ${node} /root/oselab/bin/ose_network.sh > ${logdir}/network-${node}
done
#echo "=> iptables"
#${bindir}/ose_iptables.sh > ${logdir}/iptables-${self}
#echo "=> network"
#${bindir}/ose_network.sh > ${logdir}/network-${self}
