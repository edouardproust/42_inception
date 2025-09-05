# Inception Project - 42 School

This project sets up a small infrastructure using Docker containers with Alpine Linux 3.21.4.

## Services

- Nginx (SSL termination, reverse proxy)
- WordPress (PHP-FPM)
- MariaDB (Database)
- Redis (Object caching)

## Requirements

- Docker
- Docker Compose
- Make

## Installation

1. Clone this repository
2. Configure your domain in the `.env` file
3. Run `make` to build and start the containers

## Usage

- `make` or `make up` - Build and start containers
- `make down` - Stop and remove containers
- `make stop` - Stop containers
- `make start` - Start containers
- `make ps` - Show container status
- `make logs` - Show container logs
- `make clean` - Clean up containers and images
- `make fclean` - Full clean up (containers, images, volumes, networks)
- `make re` - Rebuild everything

## Access

- WordPress: https://user.42.fr (replace with your domain)
- Database: mariadb:3306
- Redis: redis:6379

## Security

- SSL certificates are automatically generated
- Each service runs with minimal privileges
- Alpine Linux provides a minimal attack surface

## Notes

- All services are based on Alpine Linux 3.21.4
- The project follows 42 School requirements
- WordPress files are stored in a Docker volume
- Database data is persisted in a Docker volume
