#!/usr/bin/env bash

set -euo pipefail

# Authenticate with docker and push the latest image.

docker login \
    --email $DOCKER_HUB_EMAIL \
    --password $DOCKER_HUB_PASSWORD \
    --username $DOCKER_HUB_USERNAME

docker push ianbytchek/coreos-ansible-toolbox
docker logout