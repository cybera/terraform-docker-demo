#!/bin/bash

sudo apt-get update -qq
sudo apt-get install -y apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update -qq
sudo apt-get install -y docker-engine

echo "DOCKER_OPTS=\"-H tcp://0.0.0.0:2376\"" | sudo tee -a /etc/default/docker

sudo restart docker

