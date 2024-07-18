#!/bin/zsh

# Build project
./gradlew clean build

if ! make target;
 then
  echo "Build Successful. Starting Docker Compose..."
  docker-compose up -d
  else
    echo "Build failed. Docker Compose will not start. "
    exit 1
    fi