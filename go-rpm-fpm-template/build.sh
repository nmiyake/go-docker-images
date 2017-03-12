#! /bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../versions.sh"

set -euo pipefail

DOCKERFILE='FROM golang:{{GO_VERSION}}

RUN apt-get update
RUN apt-get -y install rpm
RUN apt-get -y install ruby-dev
RUN apt-get -y install rubygems
RUN gem install fpm

ENV USER_ID 1000
RUN adduser gouser --uid $USER_ID
RUN chown -R gouser /go

COPY ./run-as-gouser.sh /
RUN chmod +x /run-as-gouser.sh'

cd "$SCRIPT_DIR"
for currVersion in $GO_VERSIONS; do
  imageDir="images/go-$currVersion-rpm-fpm"
  mkdir -p "$imageDir"
  dockerfile_content="${DOCKERFILE//\{\{GO_VERSION\}\}/$currVersion}"
  echo "$dockerfile_content" > "${imageDir}/Dockerfile"
  tag="nmiyake/go:go-${currVersion}-rpm-fpm-t${CIRCLE_BUILD_NUM}"
  docker build -t "${tag}" -f "${imageDir}/Dockerfile" .
  echo "$tag" > "images/tags.txt"

  # only build for latest version
  break
done
