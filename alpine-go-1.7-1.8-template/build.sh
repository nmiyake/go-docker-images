#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "${SCRIPT_DIR}/../versions.sh"

set -euo pipefail

DOCKERFILE='FROM alpine:3.5

RUN apk add --no-cache ca-certificates

ENV GOLANG_1_7_VERSION {{GO_1_7_VERSION}}
ENV GOLANG_1_7_SRC_URL https://golang.org/dl/go$GOLANG_1_7_VERSION.src.tar.gz
ENV GOLANG_1_7_SRC_SHA256 {{GO_1_7_SRC_SHA256}}

ENV GOLANG_1_8_VERSION {{GO_1_8_VERSION}}
ENV GOLANG_1_8_SRC_URL https://golang.org/dl/go$GOLANG_1_8_VERSION.src.tar.gz
ENV GOLANG_1_8_SRC_SHA256 {{GO_1_8_SRC_SHA256}}

# https://golang.org/issue/14851
COPY no-pic-1.7.patch /
COPY no-pic-1.8.patch /
# https://golang.org/issue/17847
COPY 17847.patch /

RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
    bash \
    gcc \
    musl-dev \
    openssl \
    go \
  \
  && export GOROOT_BOOTSTRAP="$(go env GOROOT)" \
  \
  && cd / \
  && wget -q "$GOLANG_1_7_SRC_URL" -O golang.tar.gz \
  && echo "$GOLANG_1_7_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz \
  && mv /usr/local/go /usr/local/go-1.7 \
  && cd /usr/local/go-1.7/src \
  && patch -p2 -i /no-pic-1.7.patch \
  && patch -p2 -i /17847.patch \
  && ./make.bash \
  \
  && cd / \
  && wget -q "$GOLANG_1_8_SRC_URL" -O golang.tar.gz \
  && echo "$GOLANG_1_8_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz \
  && mv /usr/local/go /usr/local/go-1.8 \
  && cd /usr/local/go-1.8/src \
  && patch -p2 -i /no-pic-1.8.patch \
  && ./make.bash \
  \
  && rm -rf /*.patch \
  && apk del .build-deps

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN ln -s /usr/local/go-1.8 /usr/local/go
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/'

# replace variables in template with current versions
dockerfile_content="${DOCKERFILE//\{\{GO_1_8_VERSION\}\}/$GO_1_8}"
dockerfile_content="${dockerfile_content//\{\{GO_1_8_SRC_SHA256\}\}/$GO_1_8_SRC_SHA256}"
dockerfile_content="${dockerfile_content//\{\{GO_1_7_VERSION\}\}/$GO_1_7}"
dockerfile_content="${dockerfile_content//\{\{GO_1_7_SRC_SHA256\}\}/$GO_1_7_SRC_SHA256}"

cd "$SCRIPT_DIR"
imageDir="images/alpine-go-${GO_1_7}-${GO_1_8}"
mkdir -p "$imageDir"
echo "$dockerfile_content" > "${imageDir}/Dockerfile"
tag="nmiyake/go:alpine-go-${GO_1_7}-${GO_1_8}-t${CIRCLE_BUILD_NUM}"
docker build -t "${tag}" -f "${imageDir}/Dockerfile" .
echo "$tag" > "images/tags.txt"
