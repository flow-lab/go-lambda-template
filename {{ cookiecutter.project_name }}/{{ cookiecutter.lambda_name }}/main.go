package main

import (
	"context"
	"errors"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/lambdacontext"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sns"
	"github.com/aws/aws-xray-sdk-go/xray"
	"github.com/flow-lab/dlog"
	"strings"
)

var (
	// ErrTopicArn missing topic arn variable
	ErrTopicArn = errors.New("missing topic arn - SNS env")
	// ErrPublish SNS publish error
	ErrPublish = errors.New("unable to publish event to SNS")

	version = "dev"
	commit  = "none"
	date    = "unknown"
)

func handler(ctx context.Context, sqsEvent events.SQSEvent) error {
	lc, _ := lambdacontext.FromContext(ctx)
	logger := dlog.NewStandardLogger(&dlog.LoggerParam{
		AppName: name(lc.InvokedFunctionArn),
		Trace:   xray.TraceID(ctx),
	})

	logger.Infof("got request: %#v", sqsEvent)

	config := &aws.Config{MaxRetries: aws.Int(10)}
	sess := session.Must(session.NewSession())
	client := sns.New(sess, config)
	_ = xray.Configure(xray.Config{LogLevel: "trace"})
	xray.AWS(client.Client)

	for _, message := range sqsEvent.Records {
		logger.Infof("the message %s for event source %s = %s \n", message.MessageId, message.EventSource, message.Body)
		// TODO: implementation
	}

	return nil
}

func name(arn string) string {
	return strings.Split(arn, ":")[len(strings.Split(arn, ":"))-2]
}

func main() {
	lambda.Start(handler)
}
