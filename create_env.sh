#!/bin/bash

set -i
sex -u

sudo apt install python-dev python-pip

if [ ! -d venv ]; then
	virtualenv venv
fi
source venv/bin/activate
pip install python-openstackclient python-heatclient python-novaclient python-neutronclient


