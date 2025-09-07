DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
WP_HOST_BIND = ~/Sites/wordpress

all: up

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean:
	$(DOCKER_COMPOSE) down -v
	docker system prune -af

restart: down up

re: clean up

.PHONY: all up down clean fclean re
