#!/bin/bash

function do_command {
	local cmd="$*"
	echo "=> ${cmd}"
	${cmd}
}

echo "=> haproxy.config"
oc rsh $(oc get pod -o name | grep router) cat haproxy.config | grep -v '^\s*$'
echo "=> *.map"
oc rsh $(oc get pod -o name | grep router) /bin/bash -c 'for i in *.map; do echo "==> $i"; cat $i | grep -v "^\s*$"; done'
echo "=> routes.json"
oc rsh $(oc get pod -o name | grep router) cat ../router/routes.json
