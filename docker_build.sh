#!/usr/bin/env bash

VERSION=${1:-latest}

docker build \
  -t jvictorino/l4t-ml-realsense:r32.7.1-py3-$VERSION \
  -f Dockerfile.realsense .