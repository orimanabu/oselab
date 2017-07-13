#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 project"
	exit 1
fi
project=$1; shift

etcdctl --endpoint https://master1.example.com:4001 --cert-file /etc/origin/master/master.etcd-client.crt --key-file /etc/origin/master/master.etcd-client.key --ca-file /etc/origin/master/ca-bundle.crt get /openshift.io/registry/sdnnetnamespaces/${project} | python -m json.tool
