# Docker CoreOS Ansible toolbox

<div align="center"><img src="./documentation/asset/docker-coreos-ansible-toolbox.png"></div>

CoreOS is awesome, so is [Ansible](https://github.com/ansible/ansible). However, running Ansible tasks on CoreOS is a pain, mostly due to lack of Python, which is not there for a good reason. CoreOS [toolbox](https://github.com/coreos/toolbox) is a small script that uses containers to let you bring in your favorite tools into CoreOS. This is small-sized alternative toolbox image built specifically for running Ansible tasks on CoreOS machines, it's based on  [Alpine Linux](http://www.alpinelinux.org) and has Python, [pip](https://github.com/pypa/pip) and Ansible preinstalled, and under 70 MB in size unpacked.

[![Circle CI](https://circleci.com/gh/ianbytchek/docker-coreos-ansible-toolbox.svg?style=svg)](https://circleci.com/gh/ianbytchek/docker-coreos-ansible-toolbox)

## Attention

This repository was created with hopes of possibility to easily execute ansible commands within toolbox with full access to CoreOS resources. The general idea is great, but fails in practice when you need to do anything outside pure Python, for example, control etcd or fleet, or systemd, or something else that lives on the host. You can provide access to many things by mounting executables and dependencies as volumes, but this starts to feel hacky very quickly and sometimes doesn't work.

My advice is to setup Python on the host if dealing with similar scenarios. Otherwise, using Python withing toolbox is a neat way to do stuff, highly recommended.

## Running

Toolbox setup and installation is covered in CoreOS [documentation](https://coreos.com/os/docs/latest/install-debugging-tools.html), in a nutshell, to make it the default toolbox image you must specify `ianbytchek/coreos-ansible-toolbox` image in `~/.toolboxrc` parameters manually or via cloud-config.

```ini
TOOLBOX_DOCKER_IMAGE=ianbytchek/coreos-ansible-toolbox
TOOLBOX_USER=root
```

Vincent Ambo has a great article on [provisioning CoreOS with Ansible](https://www.tazj.in/en/1410951452). Besides configuring `~/.toolboxrc` you'll also need to create `/opt/bin/python` and `/opt/bin/pip` and set `ansible_python_interpreter` inventory variable to `/opt/bin/python`.

```sh
# Use --quiet option to prevent nspawn printing useless messages every time we call `python` and `pip`.

sudo mkdir --parents '/opt/bin'

sudo tee '/opt/bin/python' > /dev/null <<-'EOL'
	#!/bin/bash
	toolbox --quiet --bind=/home:/home --bind=/var/run/docker.sock:/var/run/docker.sock python "$@"
EOL

sudo chmod +x '/opt/bin/python'

sudo tee '/opt/bin/pip' > /dev/null <<-'EOL'
	#!/bin/bash
	toolbox --quiet --bind=/home:/home pip "$@"
EOL

sudo chmod +x '/opt/bin/pip'
```
