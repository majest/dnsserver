.PHONY: dev dev-alpine all clean deps fmt vet test docker

EXECUTABLE ?= $(shell basename `pwd`)
IMAGE ?= majest/$(EXECUTABLE)
COMMIT ?= $(shell git rev-parse --short HEAD)

LDFLAGS = -X "main.buildCommit=$(COMMIT)"
PACKAGES = $(shell go list ./... | grep -v /vendor/)

dev:
	docker run --rm  -e CGO_ENABLED=0 -v $(GOPATH):/go/ -w /go/src/github.com/majest/$(EXECUTABLE) golang:latest go build -o main

alpine:
	docker run --rm  -e CGO_ENABLED=0 -v $(GOPATH):/go/ -w /go/src/github.com/majest/$(EXECUTABLE) golang:alpine go build -o main

all:
	deps build test

clean:
	go clean -i ./...

deps:
	go get -t ./...

fmt:
	go fmt $(PACKAGES)

vet:
	go vet $(PACKAGES)

test:
	@for PKG in $(PACKAGES); do go test -cover -coverprofile $$GOPATH/src/$$PKG/coverage.out $$PKG || exit 1; done;

docker:
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o main -a -tags netgo  -ldflags '-s -w $(LDFLAGS)'
	docker build --rm -t $(IMAGE) .

$(EXECUTABLE): $(wildcard *.go)
	go build -o main -a -tags netgo -ldflags '-s -w $(LDFLAGS)'

build: $(EXECUTABLE)
