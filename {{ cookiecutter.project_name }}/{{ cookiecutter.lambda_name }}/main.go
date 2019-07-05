package main

import (
	"context"
	"errors"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/lambdacontext"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
{%- if cookiecutter.include_sns == "y" %}
	"github.com/aws/aws-sdk-go/service/sns/snsiface" {% endif %}
	"os"

	"github.com/aws/aws-sdk-go/service/sns"
	"github.com/aws/aws-xray-sdk-go/xray"
	"github.com/flow-lab/dlog"
	"strings"
)

var (
	// ErrTopicArn missning topic arn variable
	ErrTopicArn = errors.New("missing topic arn - SNS env")
	// ErrPublish SNS publish error
	ErrPublish = errors.New("unable to publish event to SNS")
)

func handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	lc, _ := lambdacontext.FromContext(ctx)
	logger := dlog.NewStandardLogger(&dlog.LoggerParam{
		AppName: getAppNameFromARN(lc.InvokedFunctionArn),
		Trace:   xray.TraceID(ctx),
	})
	logger.Infof("got request: %#v", request)

	{%- if cookiecutter.include_sns == "y" %}
	sess := session.Must(session.NewSession())
	config := &aws.Config{MaxRetries: aws.Int(10)}
	client := sns.New(sess, config)
	_ = xray.Configure(xray.Config{LogLevel: "trace"})
	xray.AWS(client.Client)

	if key, ok := os.LookupEnv("SNS"); ok {
		err := publishSNS(request.Body, key, ctx, client)
		if err != nil {
			logger.Errorf("%s: %v", ErrPublish, err)
			return events.APIGatewayProxyResponse{}, err
		}
	} else {
		logger.Error(ErrTopicArn)
		return events.APIGatewayProxyResponse{}, ErrTopicArn
	} {% endif %}

	return events.APIGatewayProxyResponse{
		StatusCode: 202,
	}, nil
}
{%- if cookiecutter.include_sns == "y" %}
func publishSNS(reqBody string, snsArn string, ctx context.Context, client snsiface.SNSAPI) error {
	input := &sns.PublishInput{
		TopicArn: aws.String(snsArn),
		Message:  aws.String(reqBody),
	}
	_, err := client.PublishWithContext(ctx, input)
	if err != nil {
		return err
	}

	return nil
} {% endif %}

func getAppNameFromARN(arn string) string {
	return strings.Split(arn, ":")[len(strings.Split(arn, ":"))-2]
}

func main() {
	lambda.Start(handler)
}
