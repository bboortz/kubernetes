#!/bin/sh

docker-machine create -d openstack  --openstack-ssh-user root --openstack-keypair-name ssh-key --openstack-private-key-file ~/.rackspace/rackspace_key --openstack-flavor-name "1 GB Performance" --openstack-image-name "CentOS 7 (PVHVM)" --openstack-net-id 00000000-0000-0000-0000-000000000000 dockerM1
