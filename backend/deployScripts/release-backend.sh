#!/bin/bash

CONTAINER_NAME="my_app_container"
DOCKER_IMAGE_NAME="bumstead/h2o-backend-server:latest"

EXISTING_CONTAINER_ID=$(docker ps -q -f "publish=$TARGET_PORT")

if [ -n "$EXISTING_CONTAINER_ID" ]; then
    echo "Stopping and removing the existing container..."
    docker stop $EXISTING_CONTAINER_ID
    docker rm $EXISTING_CONTAINER_ID
else
    echo "No existing container found."
fi

echo "Pulling the latest Docker image from Docker Hub..."
docker pull $DOCKER_IMAGE_NAME

echo "Starting the new container..."
docker run -d -p 8080:8080 $DOCKER_IMAGE_NAME

echo "Deployment completed successfully!"
