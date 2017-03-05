FROM alpine:3.5

RUN apk add --no-cache ca-certificates

ENV GOLANG_18_VERSION 1.8
ENV GOLANG_18_SRC_URL https://golang.org/dl/go$GOLANG_18_VERSION.src.tar.gz
ENV GOLANG_18_SRC_SHA256 406865f587b44be7092f206d73fc1de252600b79b3cacc587b74b5ef5c623596

ENV GOLANG_17_VERSION 1.7.5
ENV GOLANG_17_SRC_URL https://golang.org/dl/go$GOLANG_17_VERSION.src.tar.gz
ENV GOLANG_17_SRC_SHA256 4e834513a2079f8cbbd357502cccaac9507fd00a1efe672375798858ff291815

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
  && wget -q "$GOLANG_17_SRC_URL" -O golang.tar.gz \
  && echo "$GOLANG_17_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz \
  && mv /usr/local/go /usr/local/go-1.7 \
  && cd /usr/local/go-1.7/src \
  && patch -p2 -i /no-pic-1.7.patch \
  && patch -p2 -i /17847.patch \
  && ./make.bash \
  \
  && cd / \
  && wget -q "$GOLANG_18_SRC_URL" -O golang.tar.gz \
  && echo "$GOLANG_18_SRC_SHA256  golang.tar.gz" | sha256sum -c - \
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

COPY go-wrapper /usr/local/bin/
