.PHONY: deps clean build

IMG_NAME="{{ cookiecutter.lambda_name }}-build"

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

build: vet fmt
	docker image rm -f ${IMG_NAME} || true && \
	docker build -t ${IMG_NAME} --build-arg GITHUB_SHA=${GITHUB_SHA} --build-arg VERSION=0.1.0 . && \
	docker cp $(shell docker create ${IMG_NAME}):/go/src/app/deployment.zip .