#!/bin/bash

function do_command {
	local cmd="$*"
	echo "==> ${cmd}"
	${cmd}
}

function oc_get {
	local project=$1; shift
	do_command oc get all,pvc -o wide -n ${project}
	do_command oc get pod -o wide -n ${project}
	do_command oc get svc -n ${project}
	do_command oc get route -n ${project}
}

if [ x"$#" != x"1" ]; then
	echo "$0 op"
	exit 1
fi
op=$1; shift
#projects="proj1 proj2"

case ${op} in
master)
	echo "=> node"
	do_command oc get node --show-labels
	echo "=> project: all_namespaces"
	do_command oc get all,pvc -o wide --all-namespaces
	do_command oc get pod -o wide --all-namespaces
	do_command oc get svc --all-namespaces
	do_command oc get route --all-namespaces

	for project in $(oc get project -o name | sed -e 's,^project/,,'); do
		if [ x"$?" = x"0" ]; then
			echo
			echo "=> project: ${project}"
			oc_get ${project}

			echo

			echo
			echo "==>"
			for resource in $(oc get pod -o name -n ${project}); do
				echo -n '='; do_command oc describe ${resource} -n ${project}
			done
			for resource in $(oc get svc -o name -n ${project}); do
				echo -n '='; do_command oc describe ${resource} -n ${project}
			done
			for resource in $(oc get route -o name -n ${project}); do
				echo -n '='; do_command oc describe ${resource} -n ${project}
			done
		fi
	done
	;;
*)
	echo "unknow op: ${op}"
	;;
esac
