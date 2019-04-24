.PHONY: deps clean build

deps:
	go get -u ./...

clean: 
	rm -rf ./{{ template.lambda_name }}/{{ template.lambda_name }}
	
build:
	GOOS=linux GOARCH=amd64 go build -o {{ template.lambda_name }}/{{ template.lambda_name }} ./{{ template.lambda_name }}