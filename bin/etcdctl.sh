#!/bin/bash

etcdctl="etcdctl --endpoint https://master1.example.com:4001 --cert-file /etc/origin/master/master.etcd-client.crt --key-file /etc/origin/master/master.etcd-client.key --ca-file /etc/origin/master/ca-bundle.crt"

for key in $(${etcdctl} ls -r -p); do
	echo "=> ${key}"
	echo ${key} | grep '/$' > /dev/null 2>&1
	if [ x"$?" != x"0" ]; then
		${etcdctl} get ${key} | python -m json.tool
	fi
done
