#!/bin/bash

set -i
set -u

STACK_FILE="base.yaml"
STACK_NAME="base"
INSTANCE_COUNT=1
FLAVOR="1 GB Performance"

DATE=$( date "+%s" )
ID=$$-$RANDOM
TAGS="${STACK_NAME},${DATE},${ID}"

DEBUG="--debug"
WAIT_DELAY=5

./venv/bin/openstack stack create -f table --parameter "stack_name=${STACK_NAME};instance_count=${INSTANCE_COUNT};flavor=${FLAVOR}" --tags "${TAGS}" --template ${STACK_FILE} ${STACK_NAME} ${DEBUG}

while true; do
	./venv/bin/openstack stack list --tags "${TAGS}" | grep "CREATE_IN_PROGRESS" > /dev/null || break
	echo -n "."
	sleep ${WAIT_DELAY}
done

echo
./venv/bin/openstack stack show "${STACK_NAME}" 
