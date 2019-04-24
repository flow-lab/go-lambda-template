.PHONY: deps clean build

deps:
	go get -u ./...

clean: 
	rm -rf ./{{ cookiecutter.lambda_name }}/{{ cookiecutter.lambda_name }}
	
build:
	GOOS=linux GOARCH=amd64 go build -o {{ cookiecutter.lambda_name }}/{{ cookiecutter.lambda_name }} ./{{ cookiecutter.lambda_name }}