#!/bin/bash

source $( readlink -f ${0%/*} )/settings.sh

f_create_stack() {
	local lv_stackname="$1"
	local lv_stackfile="$2"
	local lv_tags="$3"
	local lv_parameter="$4"

	echo "Creating stack: ${lv_stackname} ..."
	$OPENSTACK stack create -f table --parameter "${lv_parameter}" --tags "${lv_tags}" --template ${lv_stackfile} ${lv_stackname}

	while true; do
		$OPENSTACK stack list --tags "${lv_tags}" | grep "CREATE_IN_PROGRESS" > /dev/null || break
		echo -n "."
		sleep ${WAIT_DELAY}
	done

	f_show_stack "${lv_stackname}"
	echo
	$OPENSTACK stack list --tags "${lv_tags}"

	echo "Stack created."
}


f_delete_stack() {
	local lv_stackname="$1"

	echo "Deleting stack: ${lv_stackname} ..."
	$OPENSTACK stack delete --yes ${lv_stackname}

	while true; do
		$OPENSTACK stack list | grep "DELETE_IN_PROGRESS" > /dev/null || break
		echo -n "."
		sleep ${WAIT_DELAY}
	done

	echo "stack deleted"
}


f_show_stack() {
	local lv_stackname="$1"

	echo
	echo "Stack: $f"
	$OPENSTACK stack resource list "${lv_stackname}"
	echo
	$OPENSTACK stack resource list --long -n 2 "${lv_stackname}"
	echo
	$OPENSTACK stack show "${lv_stackname}"
}

f_list_stack() {
	$OPENSTACK stack list -f value | awk '{ print $2 }' | while read f; do
		f_show_stack "$f"
	done
}

