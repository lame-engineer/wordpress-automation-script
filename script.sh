#!/bin/bash

# Check if the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root." 
   exit 1
fi

# Docker Compose file path
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Function to add /etc/hosts entry, the site name effectively gets by the user
add_etc_hosts_entry() {
    local site_name="$1"
    echo "127.0.0.1 $site_name" >> /etc/hosts
}

# Function to check if WordPress site is up and healthy
check_site_health() {
    local site_name="$1"
    local health_check_url="http://$site_name"
    local max_attempts=10
    local wait_time=5

    echo "Checking site health..."

    for ((attempt = 1; attempt <= max_attempts; attempt++)); do
        if curl --output /dev/null --silent --head --fail "$health_check_url"; then
            echo "WordPress site is up and healthy!"
            return 0
        else
            echo "Attempt $attempt: WordPress site is not yet up. Retrying in $wait_time seconds..."
            sleep "$wait_time"
        fi
    done

    echo "WordPress site is not responding or not healthy after $max_attempts attempts."
    return 1
}

# Function to open a website in the browser
get_url() {
    local site_name="$1"
    local url="http://$site_name"
    echo "Open this $url in a browser..."
}

# Start the WordPress containers
start_wordpress() {
    docker-compose -f "$DOCKER_COMPOSE_FILE" up -d
}

# Main script logic
main() {
    # Check if docker-compose and docker commands exists
    if docker -v > /dev/null 2>&1 && docker-compose -v > /dev/null 2>&1; then
    echo "Docker and Docker-Compose are installed."
    else
    echo "Docker or docker-compose is not installed. Installiation in progress..."
    sudo pacman -S docker docker-compose -y
    fi

    # Check if site name is provided as a command-line argument if not then use default example.com
    local site_name="${1:-example.com}"

    # Add /etc/hosts entry
    add_etc_hosts_entry "$site_name"

    # Start the WordPress containers
    start_wordpress

    # Check site health and get link
    if check_site_health "$site_name"; then
        get_url "$site_name"
    fi
}

# Run the script with the cli argument
main "$1"
