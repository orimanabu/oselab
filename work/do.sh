#!/bin/bash

self=$(hostname -s)
logdir=../results
bindir=../bin

mkdir -p ${logdir}
hostname | grep master && ${bindir}/ose_info.sh master > ${logdir}/oc
hostname | grep master && ${bindir}/etcdctl.sh > ${logdir}/etcd
hostname | grep master && ${bindir}/ose_router.sh > ${logdir}/router
${bindir}/ose_iptables.sh > ${logdir}/iptables-${self}
${bindir}/ose_network.sh > ${logdir}/network-${self}
