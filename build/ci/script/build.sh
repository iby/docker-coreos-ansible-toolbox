#!/usr/bin/env bash

set -euo pipefail

# Download the latest pip installer, etcdctl and fleetctl.

curl --output './src/get-pip.py' --location 'https://bootstrap.pypa.io/get-pip.py'

echo -n 'Finding fleet release url… '
url=$(curl --header "Authorization: token ${GITHUB_TOKEN}" --silent 'https://api.github.com/repos/coreos/fleet/releases' | grep 'browser_download_url' | grep -P '\-linux-amd64.tar.gz"' | head --lines 1 | cut --delimiter '"' --fields 4)
echo " OK! ${url}"

# Build the docker image.

docker build --tag "ianbytchek/coreos-ansible-toolbox" "./src"
