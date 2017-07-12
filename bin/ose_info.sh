#!/bin/bash

function do_command {
	local cmd="$*"
	echo "==> ${cmd}"
	${cmd}
}

function oc_get {
	local project=$1; shift
	do_command oc get all -o wide -n ${project}
	do_command oc get pod -o wide -n ${project}
	do_command oc get svc -n ${project}
	do_command oc get route -n ${project}
}

if [ x"$#" != x"1" ]; then
	echo "$0 op"
	exit 1
fi
op=$1; shift
project=proj1

case ${op} in
master)
	echo "=> node"
	do_command oc get node --show-labels

	echo
	echo "=> project: default"
	oc_get default

	echo
	echo "=> project: ${project}"
	oc_get ${project}

	echo
	echo "=> project: all_namespaces"
	do_command oc get all -o wide --all-namespaces
	do_command oc get pod -o wide --all-namespaces
	do_command oc get svc --all-namespaces
	do_command oc get route --all-namespaces

	echo
	echo "==>"
	for resource in $(oc get pod -o name --all-namespaces); do
		echo -n '='
		do_command oc describe ${resource}
		if [ x"$?" != x"0" ]; then
			echo -n '='; do_command oc describe ${resource} -n ${project}
		fi
	done
	for resource in $(oc get svc -o name --all-namespaces); do
		echo -n '='
		do_command oc describe ${resource}
		if [ x"$?" != x"0" ]; then
			echo -n '='; do_command oc describe ${resource} -n ${project}
		fi
	done
	for resource in $(oc get route -o name --all-namespaces); do
		echo -n '='
		do_command oc describe ${resource}
		if [ x"$?" != x"0" ]; then
			echo -n '='; do_command oc describe ${resource} -n ${project}
		fi
	done
	;;
*)
	echo "unknow op: ${op}"
	;;
esac
