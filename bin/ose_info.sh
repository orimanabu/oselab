#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 op"
	exit 1
fi
op=$1; shift

function do_command {
	local cmd="$*"
	echo "=> ${cmd}"
	${cmd}
}

case ${op} in
master)
	do_command oc get all -o wide --all-namespaces
	do_command oc get node --show-labels
	do_command oc get pod -o wide --all-namespaces
	do_command oc get svc --all-namespaces
	do_command oc get route --all-namespaces

	echo
	echo "==>"
	for resource in $(oc get pod -o name); do
		echo -n '='; do_command oc describe ${resource}
	done
	for resource in $(oc get svc -o name); do
		echo -n '='; do_command oc describe ${resource}
	done
	for resource in $(oc get route -o name); do
		echo -n '='; do_command oc describe ${resource}
	done
	;;
*)
	echo "unknow op: ${op}"
	;;
esac
