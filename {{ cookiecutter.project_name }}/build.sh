#!/usr/bin/env bash

# I am build an application in docker and then copies the resulting zipped artifact to the host machine.

# Fail on any error.
set -e

# build in docker == bid
IMG_NAME="bid-"$(date +%s)

GITHUB_SHA=$1
if [ -z "$GITHUB_SHA" ]; then
  GITHUB_SHA="dev"
fi

VERSION=$2
if [ -z "$VERSION" ]; then
  VERSION="0.0.0"
fi

rm deployment.zip || true
docker image rm -f ${IMG_NAME} || true
docker build -t ${IMG_NAME} --build-arg GITHUB_SHA=${GITHUB_SHA} --build-arg VERSION=${VERSION} .
docker cp $(docker create --platform "linux/amd64" ${IMG_NAME}):/go/src/app/deployment.zip .

echo "Build complete, artifact copied to deployment.zip file"
