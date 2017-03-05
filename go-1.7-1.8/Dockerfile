FROM buildpack-deps:jessie-scm

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
    g++ \
    gcc \
    libc6-dev \
    make \
    pkg-config \
  && rm -rf /var/lib/apt/lists/*

ENV GOLANG_17_VERSION 1.7.5
ENV GOLANG_17_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_17_VERSION.linux-amd64.tar.gz
ENV GOLANG_17_DOWNLOAD_SHA256 2e4dd6c44f0693bef4e7b46cc701513d74c3cc44f2419bf519d7868b12931ac3

ENV GOLANG_18_VERSION 1.8
ENV GOLANG_18_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_18_VERSION.linux-amd64.tar.gz
ENV GOLANG_18_DOWNLOAD_SHA256 53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca

RUN curl -fsSL "$GOLANG_17_DOWNLOAD_URL" -o golang.tar.gz \
  && echo "$GOLANG_17_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz \
  && mv /usr/local/go /usr/local/go-1.7

RUN curl -fsSL "$GOLANG_18_DOWNLOAD_URL" -o golang.tar.gz \
  && echo "$GOLANG_18_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
  && tar -C /usr/local -xzf golang.tar.gz \
  && rm golang.tar.gz \
  && mv /usr/local/go /usr/local/go-1.8

RUN ln -s /usr/local/go-1.8 /usr/local/go

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
