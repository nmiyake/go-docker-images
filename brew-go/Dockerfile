FROM linuxbrew/linuxbrew:latest

RUN brew install go

RUN sudo mkdir /go
RUN sudo chown -R $(whoami):$(whoami) /go

ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin"

WORKDIR $GOPATH
