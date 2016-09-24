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

WAIT_DELAY=5

./venv/bin/openstack stack delete ${STACK_NAME}

while true; do
	./venv/bin/openstack stack list | grep "DELETE_IN_PROGRESS" > /dev/null || break
	echo -n "."
	sleep ${WAIT_DELAY}
done

echo "stack deleted"
