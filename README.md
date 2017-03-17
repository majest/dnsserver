Simple DNS Server
==========

Simple DNS server written using [github.com/docker/dnsserver](http://github.com/docker/dnsserver)

Run using docker:

`docker run -d -p 53:53/udp -p 53:53/tcp -e ZONE="com" -e DOMAINS="test=192.168.1.1" majest/dnsserver`

Use environment variables to define the A records

`ZONE="com"` and `DOMAINS="test=192.168.1.1,mydomain=10.10.10.10"` Should create:

- test.com pointing to 192.168.1.1
- mydomain.com pointing to 10.10.10.10


You can pull the code and use `docker-composer up -d` to start the container.

`make docker` - Recompile and build docker image

`make dev` - Build for golang:latest

`make alpine` - Build for golang:alpine
