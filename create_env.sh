#!/bin/bash

set -i
#set -u

sudo apt install python-dev python-pip

if [ ! -d venv ]; then
	virtualenv venv
fi
source venv/bin/activate
pip install --upgrade ansible python-openstackclient python-heatclient python-novaclient python-neutronclient python-swiftclient


