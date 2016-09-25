#!/bin/bash

set -i
set -u

STACK_FILE="base.yaml"
STACK_NAME="base"
ENTRY_INSTANCE_COUNT=1
APP_INSTANCE_COUNT=1
SERVICE_INSTANCE_COUNT=1
FLAVOR="1 GB Performance"

DATE=$( date "+%s" )
ID=$$-$RANDOM
TAGS="${STACK_NAME},${DATE},${ID}"

DEBUG="--debug"
DEBUG=""
WAIT_DELAY=5

./venv/bin/openstack stack create -f table --parameter "stack_name=${STACK_NAME};entry_instance_count=${ENTRY_INSTANCE_COUNT};app_instance_count=${APP_INSTANCE_COUNT};service_instance_count=${SERVICE_INSTANCE_COUNT};flavor=${FLAVOR}" --tags "${TAGS}" --template ${STACK_FILE} ${STACK_NAME} ${DEBUG}

while true; do
	./venv/bin/openstack stack list --tags "${TAGS}" | grep "CREATE_IN_PROGRESS" > /dev/null || break
	echo -n "."
	sleep ${WAIT_DELAY}
done

echo
./venv/bin/openstack stack resource list "${STACK_NAME}" 
echo
./venv/bin/openstack stack show "${STACK_NAME}" 
echo
./venv/bin/openstack stack list --tags "${TAGS}" 
