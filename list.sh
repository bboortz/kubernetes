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
DEBUG=""
WAIT_DELAY=5


./venv/bin/openstack stack list -f value | awk '{ print $2 }' | while read f; do
	echo 
	echo "Stack: $f"
	./venv/bin/openstack stack resource list $f
	./venv/bin/openstack stack resource list base --long -n 2
done

