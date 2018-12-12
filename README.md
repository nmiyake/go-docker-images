go-docker-images
================

Docker images for Go.

See https://hub.docker.com/r/nmiyake/go/tags/ for the latest published images.

alpine-go-{{LATEST_GO_VERSION}}-t{{tag#}}, alpine-go-{{PREVIOUS_GO_VERSION}}-t{{tag#}}
--------------------------------------------------------------------------------------
Docker images based on `golang:<version>-alpine` images that also have `bash`, `git` and `openssl` installed.

alpine-go-{{LATEST_GO_VERSION}}-java-8u181-t{{tag#}}
----------------------------------------------------
Docker images based on the `alpine-go-{{LATEST_GO_VERSION}}-t{{tag#}}` image that also has Java 8u181 from OpenJDK.

go-darwin-linux-{{LATEST_GO_VERSION}}-t{{tag#}}
-----------------------------------------------
Docker image with the latest version of Go with the standard libraries for darwin and linux installed using `go install std`.

go-darwin-linux-no-cgo-{{LATEST_GO_VERSION}}-t{{tag#}}
------------------------------------------------------
Docker image with the latest version of Go with the standard libraries for darwin and linux with CGo disabled installed using
`go install std`.

go-darwin-linux-no-cgo-{{LATEST_GO_VERSION}}-java-8u181-t{{tag#}}
-----------------------------------------------------------------
Docker image based on the `go-darwin-linux-no-cgo-{{LATEST_GO_VERSION}}-t{{tag#}}` image that also has Java 8u181 from OpenJDK.

go-darwin-linux-no-cgo-{{LATEST_GO_VERSION}}-java-11-t{{tag#}}
--------------------------------------------------------------
Docker image based on the `go-darwin-linux-no-cgo-{{LATEST_GO_VERSION}}-t{{tag#}}` image that also has Java 11 from OpenJDK.

brew-go-t{{tag#}}
-----------------
Docker image with Go installed using `brew` on Linux. Useful for testing that Go tools and programs behave properly on systems
that have installed Go using `brew`. The Go installation in this contianer is similar to the installation that occurs for Go
using `brew` on Darwin systems.

Other tags
----------
Also publishes some variants of the above images that have certain binaries preinstalled.
