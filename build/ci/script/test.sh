#!/usr/bin/env bash

set -euo pipefail

echo -n "Verify Python is installed."
if [ $(docker run 'ianbytchek/coreos-ansible-toolbox' which python) == '/usr/bin/python' ]; then
echo ' OK!'; else echo ' Fail!'; exit 1; fi;

echo -n "Verify Ansible is installed."
if [ $(docker run 'ianbytchek/coreos-ansible-toolbox' which ansible) == '/usr/bin/ansible' ]; then
echo ' OK!'; else echo ' Fail!'; exit 1; fi;
