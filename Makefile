DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
STATIC_WEBSITE_PATH_ON_HOST = /home/${USER}/Sites/static
SECRETS_PATH=secrets
ENV_FILE=srcs/.env
TOOLS_PATH=srcs/requirements/tools

all: secrets env up

secrets:
	$(TOOLS_PATH)/make_secrets.sh

env:
	$(TOOLS_PATH)/make_env.sh

up:
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean:
	$(DOCKER_COMPOSE) down -v
	docker system prune -af

fclean: clean
	rm -rf $(SECRETS_PATH)
	rm $(ENV_FILE)

restart: down up

re: clean all

fre: fclean all

nginx:
	$(DOCKER_COMPOSE) build nginx
	$(DOCKER_COMPOSE) up -d --force-recreate nginx

wordpress:
	$(DOCKER_COMPOSE) build wordpress
	$(DOCKER_COMPOSE) up -d --force-recreate wordpress

static:
	$(DOCKER_COMPOSE) build static
	$(DOCKER_COMPOSE) up -d

ftp:
	$(DOCKER_COMPOSE) build ftp
	$(DOCKER_COMPOSE) up -d --force-recreate ftp

help:
	@echo "Available commands:"
	@echo "secrets"
	@echo "up"
	@echo "down"
	@echo "clean"
	@echo "fclean"
	@echo "re"
	@echo "fre"
	@echo "nginx"
	@echo "wordpress"
	@echo "static"
	@echo "help"

.PHONY: all secrets up down clean fclean re fre nginx wordpress static ftp help
