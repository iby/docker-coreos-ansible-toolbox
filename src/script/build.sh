#!/usr/bin/env sh

cd $(dirname $0)

# Update and install apk packages.

echo 'Installing Python.'
apk --update add \
    py-crypto \
    python

# Install pip.

echo 'Installing pip.'
python /docker/get-pip.py

# Installing ansible.

echo 'Installing Ansible.'
pip install ansible

echo -n 'Cleaning up container…'

rm -rf \
    /docker \
    /var/cache/apk/*

echo ' OK!'