set -i
set -u


WAIT_DELAY=5
DATE=$( date "+%s" )
ID=$$-$RANDOM

#DEBUG="--debug"
DEBUG=""
#CACERT="--insecure"
CACERT=""

OPENSTACK=$(readlink -f ${0%/*} )"/venv/bin/openstack ${DEBUG} ${CACERT}"

