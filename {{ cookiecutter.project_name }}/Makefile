.PHONY: deps clean build

GITHUB_SHA=$(shell git rev-parse --short HEAD)
VERSION=$(shell git describe --tags --always --dirty)

deps:
	@go get -u ./...

vet:
	@go vet ./...

fmt:
	@go fmt ./...

test:
	@go test -covermode=atomic -installsuffix "static" ./...

clean:
	rm -rf ./cmd/{{ cookiecutter.lambda_name }}/{{ cookiecutter.lambda_name }}

build-local: vet fmt
	rm deployment.zip || true && \
  	GOOS=linux GOARCH=amd64 go build -o out/lambda ./cmd/lambda && \
  	zip -j deployment.zip out/*

build: vet fmt
	./build.sh ${GITHUB_SHA} ${VERSION}
