#!/bin/bash

source $( readlink -f ${0%/*} )/lib.sh

STACK_FILE="base.yaml"
STACK_NAME="base"
ENTRY_INSTANCE_COUNT=1
APP_INSTANCE_COUNT=1
SERVICE_INSTANCE_COUNT=1
FLAVOR="1 GB Performance"

TAGS="${STACK_NAME},${DATE},${ID}"
PARAMETER="stack_name=${STACK_NAME};entry_instance_count=${ENTRY_INSTANCE_COUNT};app_instance_count=${APP_INSTANCE_COUNT};service_instance_count=${SERVICE_INSTANCE_COUNT};flavor=${FLAVOR}"


f_create_stack "${STACK_NAME}" "${STACK_FILE}" "${TAGS}" "${PARAMETER}"
