Simple DNS Server wrapper
==========

Simple DNS server using github.com/docker/dnsserver

Run using docker:

`docker run -d -p 53:53/udp -p 53:53/tcp -e ZONE="com" -e DOMAINS="test=192.168.1.1" majest/dnsserver`

You can pull the code and use `docker-composer up -d` to start the container.

`make docker` - Recompile and build docker image

`make dev` - Build for golang:latest

`make alpine` - Build for golang:alpine
