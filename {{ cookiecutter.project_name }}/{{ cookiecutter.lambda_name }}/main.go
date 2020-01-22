package main

import (
	"context"
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-lambda-go/lambdacontext"
	"github.com/aws/aws-xray-sdk-go/xray"
	"github.com/flow-lab/dlog"
	"strings"
)

var (
	version = "dev"
	commit  = "none"
	date    = "unknown"
)

func handler(ctx context.Context, sqsEvent events.SQSEvent) error {
	lc, _ := lambdacontext.FromContext(ctx)
	_ = xray.Configure(xray.Config{LogLevel: "trace"})

	logger := dlog.NewStandardLogger(&dlog.LoggerParam{
		AppName: name(lc.InvokedFunctionArn),
		Trace:   xray.TraceID(ctx),
		Version: version,
		Commit:  short(commit),
		Build:   date,
	})

	logger.Infof("got request: %#v", sqsEvent)

	for _, message := range sqsEvent.Records {
		logger.Infof("the message %s for event source %s = %s \n", message.MessageId, message.EventSource, message.Body)
		// TODO: implementation
	}

	return nil
}

func name(arn string) string {
	if "" == arn {
		return ""
	}
	return strings.Split(arn, ":")[len(strings.Split(arn, ":"))-1]
}

func short(s string) string {
	if len(s) > 7 {
		return s[0:7]
	}
	return s
}

func main() {
	lambda.Start(handler)
}
