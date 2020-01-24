package main

import (
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestHandler(t *testing.T) {
	t.Run("Should ok name", func(t *testing.T) {
		assert.Equal(t, "", name(""))
		assert.Equal(t, "my-go-lambda", name("arn:aws:lambda:eu-north-1:103215310676:function:my-go-lambda"))
	})
}
