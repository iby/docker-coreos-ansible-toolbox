# Docker CoreOS Ansible toolbox

<div align="center"><img src="./documentation/asset/docker-coreos-ansible-toolbox.png"></div>

CoreOS is awesome, so is [Ansible](https://github.com/ansible/ansible). However, running Ansible tasks on CoreOS is a pain, mostly due to lack of Python, which is not there for a good reason. CoreOS [toolbox](https://github.com/coreos/toolbox) is a small script that uses containers to let you bring in your favorite tools into CoreOS. This is small-sized alternative toolbox image built specifically for running Ansible tasks on CoreOS machines, it's based on  [Alpine Linux](http://www.alpinelinux.org) and has Python, [pip](https://github.com/pypa/pip) and Ansible preinstalled, and under 70 MB in size unpacked.

[![Circle CI](https://circleci.com/gh/ianbytchek/docker-coreos-ansible-toolbox.svg?style=svg)](https://circleci.com/gh/ianbytchek/docker-coreos-ansible-toolbox)

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
	toolbox --quiet --bind=/home:/home python "$@"
EOL

sudo chmod +x '/opt/bin/python'

sudo tee '/opt/bin/pip' > /dev/null <<-'EOL'
	#!/bin/bash
	toolbox --quiet --bind=/home:/home pip "$@"
EOL

sudo chmod +x '/opt/bin/pip'
```
