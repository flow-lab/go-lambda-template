FROM golang:1.19-alpine3.16@sha256:46752c2ee3bd8388608e41362964c84f7a6dffe99d86faeddc82d917740c5968 as builder

RUN apk update && apk upgrade && \
    apk add --no-cache openssh zip \
    && rm -rf /var/cache/apk/*

WORKDIR /go/src/app
COPY . .

ENV CGO_ENABLED=0
ENV GO111MODULE=on

ARG GITHUB_SHA
ARG VERSION

RUN go test -v ./...
RUN GOOS=linux GOARCH=amd64 go build -mod=readonly -ldflags="-w -s -X 'main.version=${VERSION}' -X 'main.commit=${GITHUB_SHA}' -X 'main.date=$(date --utc +%FT%TZ)'" -o out/lambda ./cmd/{{ cookiecutter.lambda_name }}
RUN zip -j deployment.zip out/*
