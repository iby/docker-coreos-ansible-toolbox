#!/usr/bin/env sh

set -euo pipefail

cd $(dirname $0)

# Update and install apk packages.

echo 'Installing Python.'
apk --update add \
    py-crypto \
    python \
    tzdata

# Install pip.

echo 'Installing pip.'
python /docker/get-pip.py

# Install etcdctl and fleetctl.

echo -n 'Installing etcdctl and fleetctl…'
echo '' >> /etc/profile

mv /docker/etcdctl /usr/bin/

mv /docker/fleetctl /usr/bin/
echo "export FLEETCTL_ENDPOINT='unix:///media/root/var/run/fleet.sock'" >> /etc/profile

echo ' OK!'

# Installing ansible.

echo 'Installing Ansible.'
pip install ansible

echo -n 'Cleaning up container…'

rm -rf \
    /docker \
    /var/cache/apk/*

echo ' OK!'