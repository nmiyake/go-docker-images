FROM golang:1.8.0

RUN apt-get update
RUN apt-get -y install rpm
RUN apt-get -y install ruby-dev
RUN apt-get -y install rubygems
RUN gem install fpm

RUN adduser gouser
RUN chown -R gouser /go

WORKDIR /go
USER gouser
