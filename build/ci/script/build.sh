#!/usr/bin/env bash

# Setup error trapping.

set -e
trap 'echo "Error occured on line $LINENO." && exit 1' ERR

# Download the latest pip installer and build the docker image.

curl --output './src/get-pip.py' --location 'https://bootstrap.pypa.io/get-pip.py'

docker build --tag "ianbytchek/coreos-ansible-toolbox" "./src"