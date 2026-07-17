# Turtlebot Simulation

## Description


## Development

--To-do description--

#### Dependencies
1. Install [Docker Engine](https://docs.docker.com/engine/install/ubuntu/)

When your computer has NVIDIA GPU, consider making sure you also have the NVIDIA drivers, NVIDIA container toolkit installed:

2. NVIDIA Drivers in Ubuntu: https://documentation.ubuntu.com/server/how-to/graphics/install-nvidia-drivers/
3. NVIDIA Container Toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html


## Build the docker
To build the docker images, change to the workspace directory that contains Docker files and run:
```bash
docker compose -f docker/docker-compose.yml build

xhost +local:docker

docker compose -f docker/docker-compose.yml run --remove-orphans turtle-dev
```
