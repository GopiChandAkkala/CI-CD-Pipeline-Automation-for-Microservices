#!/bin/bash
set -e

# Stop the running container (if any)
echo "Hi"
docker rm -f $(docker ps -aq)
