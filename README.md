go-docker-images
================

Docker images for Go.

alpine-go-1.6, alpine-go-1.7.5, alpine-go-1.8.0
-----------------------------------------------
Docker images based on `golang:<version>-alpine` images that also have `bash`, `git` and `openssl` installed.

alpine-go-1.7-1.8
-----------------
A combination of the `golang:1.7-alpine` and `golang:1.8-alpine` images. The Go 1.7 directory is in `/usr/local/go-1.7` and the Go 1.8 directory is in `/usr/local/go-1.8`. The `GOROOT` is `/usr/local/go`, and `/usr/local/go` is a symlink to `/usr/local/go-1.8`.

brew-go
-------
Docker image with Go installed using `brew` on Linux. Useful for testing that Go tools and programs behave properly on systems that have installed Go using `brew`. The Go installation in this contianer is similar to the installation that occurs for Go using `brew` on Darwin systems.

go-1.7-1.8
----------
A combination of the `golang:1.7` and `golang:1.8` images. The Go 1.7 directory is in `/usr/local/go-1.7` and the Go 1.8 directory is in `/usr/local/go-1.8`. The `GOROOT` is `/usr/local/go`, and `/usr/local/go` is a symlink to `/usr/local/go-1.8`.

go-1.8-rpm-fpm
--------------
Docker image based on `golang:1.8` that also has `rpm` and `fpm` installed. The user creates a user called `gouser`. By default, this user is not used (the container is still run as `root` by default). However, the image contains a script called `/run-as-gouser.sh` that can be used to run the provided commands as `gouser`. The `USER_ID` environment variable can be used to set the UID of `gouser`.

go-darwin-linux
---------------
Uses the latest version of Go with the standard libraries for darwin and linux installed using `go install std`.

go-darwin-linux-no-cgo
----------------------
Uses the latest version of Go with the standard libraries for darwin and linux installed using `go install std` with `CGO_ENABLED=0`.
