#!/bin/bash

if command -v docker >/dev/null 2>&1;
   command -v docker-compose >/dev/null 2>&1; then
    echo "Docker and Docker-Compose are installed."
    # Additional actions for when Docker is installed
else
    echo "Docker is not installed. Installiation in progress..."
    sudo pacman -S docker docker-compose
    # Additional actions for when Docker is not installed
fi
