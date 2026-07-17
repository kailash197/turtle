#!/usr/bin/bash

set -e

DOCKERHUB_USER="kkhadka343"
TAG="latest"
SERVICE1="jazzy-base"
SERVICE2="turtlebot"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while true; do
    clear
    echo "======================================"
    echo " Turtle Development Environment"
    echo "======================================"
    echo
    echo "1) Pull latest image"
    echo "2) Build locally"
    echo "3) Push image to Docker Hub"
    echo "4) Run container"
    echo "5) Exit"
    echo

    read -rp "Select an option [1-5]: " choice

    case "$choice" in
        1)            
            echo "Pulling latest image..."        
            echo "==========================================="
            cd ${SCRIPT_DIR} && docker compose -f docker/docker-compose.yml pull || echo "Failed to pull the image."
            ;;
        2)
            echo
            echo "Building docker image..."
            echo "==========================================="
            cd ${SCRIPT_DIR} && docker compose -f docker/docker-compose.yml build ${SERVICE1}
            cd ${SCRIPT_DIR} && docker compose -f docker/docker-compose.yml build ${SERVICE2}
            ;;
        3)
            echo
            echo "Pushing image to Docker Hub..."
            cd ${SCRIPT_DIR} && docker compose -f docker/docker-compose.yml push
            ;;        
        4)
            echo
            xhost +local:docker

            echo "Starting turtlebot docker container..."
            echo "==========================================="
            cd ${SCRIPT_DIR} && docker compose -f docker/docker-compose.yml run --remove-orphans ${SERVICE2}
            ;;
        5)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo
            echo "❌ Invalid option. Please choose 1-6."
            ;;
    esac

    echo
    read -rp "Press Enter to return to the menu..."
done
