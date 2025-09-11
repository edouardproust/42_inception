DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
STATIC_WEBSITE_PATH_ON_HOST = /home/${USER}/Sites/static

all: prod

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean:
	$(DOCKER_COMPOSE) down -v
	docker system prune -af

restart: down up

re: clean up

nginx:
	$(DOCKER_COMPOSE) build nginx
	$(DOCKER_COMPOSE) up -d --force-recreate nginx

wordpress:
	$(DOCKER_COMPOSE) build wordpress
	$(DOCKER_COMPOSE) up -d --force-recreate wordpress

static:
	$(DOCKER_COMPOSE) build static
	$(DOCKER_COMPOSE) up -d

.PHONY: all up down clean fclean re nginx wordpress static
