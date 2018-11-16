#!/bin/bash

function do_command {
	local cmd="$*"
	echo "=> ${cmd}"
	${cmd}
}

do_command iptables -nL
do_command iptables -nL -t nat
do_command iptables -S
do_command iptables -S -t nat
