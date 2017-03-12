MAKEFLAGS += --jobs=3

build:
	@alpine-go-1.7-1.8-template/build.sh &&\
	alpine-go-template/build.sh &&\
	brew-go/build.sh &&\
	go-1.7-1.8-template/build.sh &&\
	go-rpm-fpm-template/build.sh

clean:
	@alpine-go-1.7-1.8-template/clean.sh &&\
	alpine-go-template/clean.sh &&\
	brew-go/clean.sh &&\
	go-1.7-1.8-template/clean.sh &&\
	go-rpm-fpm-template/clean.sh

.PHONY: build clean
