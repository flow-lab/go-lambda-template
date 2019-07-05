.PHONY: deps clean build

deps:
	@go get -u ./...

vet:
	@go vet ./...

fmt:
	@go fmt ./...

test:
	@go test -covermode=atomic -installsuffix "static" ./...

clean: 
	rm -rf ./{{ cookiecutter.lambda_name }}/{{ cookiecutter.lambda_name }}
	
build: vet test
	GOOS=linux GOARCH=amd64 go build -o {{ cookiecutter.lambda_name }}/{{ cookiecutter.lambda_name }} ./{{ cookiecutter.lambda_name }}