#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull akkalagopi/hello-world-python

# Run the Docker image as a container
docker run -d -p 5000:5000 akkalagopi/hello-world-python