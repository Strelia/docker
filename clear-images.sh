#!/bin/bash

docker kill $(docker ps -a -q);
docker rm $(docker ps -a -q);
docker rmi $(docker images -q) -f;

docker volume rm $(docker volume ls)