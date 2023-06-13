#!/bin/bash

if command -v docker >/dev/null 2>&1;  #with this you can also have the location where the docker is actually residing
   command -v docker-compose >/dev/null 2>&1; then
   # or you can use simply docker -v, through docker -v makes more sense.
    echo "Docker and Docker-Compose are installed."
    
else
    echo "Docker is not installed. Installiation in progress..."
    sudo pacman -S docker docker-compose
   
fi
