# {{ cookiecutter.lambda_name }}

{{ cookiecutter.project_short_description }}

Lambda features:

* Fast and minimal resource usage
* Full CI/CD with Terraform and GitHub Actions
* Terraform plan on Pull Request
* Structured logs with (commit sha, version, build date ...). Datadog friendly.
* XRay support

Below is a brief explanation of what we have generated for you using [go-lambda-template](https://github.com/flow-lab/go-lambda-template):

```shell
.
├── .github                         <-- GitHub Actions for test, build and deployment
├── infra                           <-- Terraform infrastructure
├── Dockerfile                      <-- GitHub Actions is using to build in docker
├── Makefile                        <-- Make to automate local build
├── README.md                       <-- This instructions file
├── go.mod                          <-- Defines the module’s module path
├── go.sum                          <-- Contain the expected cryptographic hashes of the content of specific module versions
├── {{ cookiecutter.lambda_name }}  <-- Source code for a lambda function
.   ├── main.go                     <-- Lambda function code
    └── main_test.go                <-- Unit tests
```

## Requirements

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

Done with [terraform](./infra) and [Github Actions](./.github/workflows). 

The GitHub secrets have to be for project

* GITHUB_TOKEN - comment on PR
* AWS_ACCESS_KEY_ID - service user key id
* AWS_SECRET_ACCESS_KEY - service user access key

### Testing

We use `testing` package that is built-in in Golang and you can simply run the following command to run our tests:

```shell
make test
```
