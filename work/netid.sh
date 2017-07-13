#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 project"
	exit 1
fi
project=$1; shift

output=$(etcdctl --endpoint https://master1.example.com:4001 --cert-file /etc/origin/master/master.etcd-client.crt --key-file /etc/origin/master/master.etcd-client.key --ca-file /etc/origin/master/ca-bundle.crt get /openshift.io/registry/sdnnetnamespaces/${project} 2> /dev/null)

echo ${output}

vnid=$(echo "${output}" | python -m json.tool | grep netid | sed -e 's/.*: \([0-9]\+\),/\1/')
echo ${vnid}
printf "0x%x\n" ${vnid}
