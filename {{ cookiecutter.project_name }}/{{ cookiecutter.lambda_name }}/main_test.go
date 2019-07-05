package main

import (
	"context"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/request"
	"github.com/aws/aws-sdk-go/service/sns"
	"github.com/aws/aws-sdk-go/service/sns/snsiface"
	"testing"
)

type snsMock struct {
	snsiface.SNSAPI
}

func (c *snsMock) PublishWithContext(ctx aws.Context, input *sns.PublishInput, opts ...request.Option) (*sns.PublishOutput, error) {
	return &sns.PublishOutput{}, nil
}

func TestHandler(t *testing.T) {
	t.Run("Should publish", func(t *testing.T) {
		mock := &snsMock{}
		err := publishSNS("test", "arn", context.Background(), mock)
		if err != nil {
			t.Fatal("error should not be returned")
		}
	})
}
