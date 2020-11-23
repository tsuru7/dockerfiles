#!/bin/bash

docker run -it -p 2022:22 -p 8888:8888 -v ~/.ssh:/home/${USER}/.ssh -v ~/repos:/home/${USER}/repos --name test_env ${USER}/my_test_image
