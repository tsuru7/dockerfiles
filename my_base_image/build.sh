#!/bin/bash

docker build -t ${USER}/my_base_image --build-arg USER_ID=$(id -u) --build-arg USER_NAME=${USER} -f Dockerfile .

