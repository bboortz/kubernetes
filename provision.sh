#!/bin/bash

set -i
set -u

STACK_FILE="base.yaml"
STACK_NAME="base"
INSTANCES=1
FLAVOR="1 GB Performance"

DATE=$( date "+%s" )
ID=$$-$RANDOM
TAGS="${STACK_NAME},${DATE},${ID}"

WAIT_DELAY=15

./venv/bin/openstack stack create -f table --parameter "stack_name=${STACK_NAME};instances=${INSTANCES};flavor=${FLAVOR}" --tags "${TAGS}" --template ${STACK_FILE} ${STACK_NAME}

while true; do
	./venv/bin/openstack stack list --tags "${TAGS}" | grep "CREATE_IN_PROGRESS" || break
	sleep ${WAIT_DELAY}
done

echo
./venv/bin/openstack stack show "${STACK_NAME}" 
