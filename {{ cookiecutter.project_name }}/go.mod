module github.com/flow-lab/{{ cookiecutter.lambda_name }}

go 1.21

require (
	github.com/aws/aws-lambda-go v1.41.0
	github.com/aws/aws-xray-sdk-go v1.8.2
	github.com/flow-lab/dlog v1.3.0
	github.com/flow-lab/utils v1.2.0
	github.com/stretchr/testify v1.8.4
// just in case
//github.com/aws/aws-sdk-go-v2/config v1.17.9
//github.com/aws/aws-sdk-go-v2/feature/s3/manager v1.11.36
//github.com/aws/aws-sdk-go-v2/service/s3 v1.29.0
//github.com/aws/aws-sdk-go-v2/service/ssm v1.31.3
)

require (
	github.com/andybalholm/brotli v1.0.6 // indirect
	github.com/aws/aws-sdk-go v1.46.7 // indirect
	github.com/davecgh/go-spew v1.1.1 // indirect
	github.com/golang/protobuf v1.5.3 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/klauspost/compress v1.17.2 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pmezard/go-difflib v1.0.0 // indirect
	github.com/sirupsen/logrus v1.9.3 // indirect
	github.com/valyala/bytebufferpool v1.0.0 // indirect
	github.com/valyala/fasthttp v1.50.0 // indirect
	golang.org/x/net v0.17.0 // indirect
	golang.org/x/sys v0.13.0 // indirect
	golang.org/x/text v0.13.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20231030173426-d783a09b4405 // indirect
	google.golang.org/grpc v1.59.0 // indirect
	google.golang.org/protobuf v1.31.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
