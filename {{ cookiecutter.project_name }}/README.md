# {{ cookiecutter.lambda_name }}

This is a sample template for {{ cookiecutter.lambda_name }} - Below is a brief explanation of what we have generated for you:

```shell
.
├── Makefile                    <-- Make to automate build
├── README.md                   <-- This instructions file
├── go.mod                      <-- Defines the module’s module path
├── go.sum                      <-- Contain the expected cryptographic hashes of the content of specific module versions
├── {{ cookiecutter.lambda_name }}                      <-- Source code for a lambda function
│   ├── main.go                 <-- Lambda function code
│   └── main_test.go            <-- Unit tests
└──
```

## Requirements

* AWS CLI already configured with Administrator permission
* [Golang](https://golang.org)

## Setup process

### Installing dependencies

In this example we use the built-in `go get` and the only dependency we need is AWS Lambda Go SDK:

```shell
make deps
```

**NOTE:** As you change your application code as well as dependencies during development, you might want to research how to handle dependencies in Golang at scale.

### Building

Golang is a statically compiled language, meaning that in order to run it you have to build the executable target.

You can issue the following command in a shell to build it:

```shell
make build
```

**NOTE**: If you're not building the function on a Linux machine, you will need to specify the `GOOS` and `GOARCH` environment variables, this allows Golang to build your function for another system architecture and ensure compatibility.

### Local development

TODO: 

## Packaging and deployment

Done with terraform and Github Actions.

### Testing

We use `testing` package that is built-in in Golang and you can simply run the following command to run our tests:

```shell
make test
```
