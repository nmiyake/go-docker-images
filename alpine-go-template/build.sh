#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../versions.sh"

set -euo pipefail

DOCKERFILE='FROM golang:{{GO_VERSION}}-alpine

RUN apk add --no-cache bash git openssl'

cd "$SCRIPT_DIR"
tags=""
for currVersion in $GO_VERSIONS; do
  imageDir="images/alpine-go-$currVersion"
  mkdir -p "$imageDir"
  dockerfile_content="${DOCKERFILE//\{\{GO_VERSION\}\}/$currVersion}"
  echo "$dockerfile_content" > "${imageDir}/Dockerfile"
  tag="nmiyake/go:alpine-go-${currVersion}-t${CIRCLE_BUILD_NUM}"
  tags="${tags}${tag}\n"
  docker build -t "${tag}" -f "${imageDir}/Dockerfile" .
done
echo -e -n "${tags}" > images/tags.txt
