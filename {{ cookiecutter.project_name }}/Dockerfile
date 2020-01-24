FROM golang:alpine as builder

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh gcc musl-dev zip

WORKDIR /go/src/app
COPY . .

ENV CGO_ENABLED=0
ENV GO111MODULE=on

ARG GITHUB_SHA
ARG VERSION

RUN GOOS=linux GOARCH=amd64 go build -mod=readonly -ldflags="-w -s -X 'main.version=${VERSION}' -X 'main.commit=${GITHUB_SHA}' -X 'main.date=$(date --utc +%FT%TZ)'" -o out/lambda ./cmd/{{ cookiecutter.lambda_name }}
RUN zip -j deployment.zip out/*
