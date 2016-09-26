#!/bin/bash

source $( readlink -f ${0%/*} )/lib.sh

STACK_NAME="base"


f_delete_stack "${STACK_NAME}"

