#!/bin/bash

CONTAINER_ID=$(docker ps -a | grep "example-renderer-aws-lambda" | awk '{print $1}')

if [ ! -z "$CONTAINER_ID" ];
then
  echo "Stopping and removing container..."
  docker stop $CONTAINER_ID 2>&1
  docker rm $CONTAINER_ID 2>&1
fi

IMAGE_NAME=$(docker images | grep "example-renderer-aws-lambda" | awk '{print $1}')

if [ ! -z "$IMAGE_NAME" ];
then
  echo "Removing image..."
  docker rmi $IMAGE_NAME 2>&1
fi

rm -rf node_modules

yarn

cp -R ../../fixtures fixtures

docker build . -t example-renderer-aws-lambda:latest

rm -rf fixtures
