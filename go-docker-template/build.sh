#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../versions.sh"

set -euo pipefail

DOCKERFILE='FROM golang:{{GO_VERSION}}

ENV DOCKER_VERSION {{DOCKER_VERSION}}
RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://get.docker.com/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz
RUN tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz
RUN  mv /tmp/docker/* /usr/bin'

cd "$SCRIPT_DIR"
tags=""
for currVersion in $GO_VERSIONS; do
  imageDir="images/go-${currVersion}-docker-${DOCKER_VERSION}"
  mkdir -p "$imageDir"
  dockerfile_content="${DOCKERFILE//\{\{GO_VERSION\}\}/$currVersion}"
  dockerfile_content="${dockerfile_content//\{\{DOCKER_VERSION\}\}/$DOCKER_VERSION}"
  echo "$dockerfile_content" > "${imageDir}/Dockerfile"
  tag="nmiyake/go:go-${currVersion}-docker-${DOCKER_VERSION}-t${CIRCLE_BUILD_NUM}"
  tags="${tags}${tag}\n"
  docker build -t "${tag}" -f "${imageDir}/Dockerfile" .
done
echo -e -n "${tags}" > images/tags.txt
