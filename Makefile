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

re: fclean all

nginx:
	$(DOCKER_COMPOSE) build nginx
	$(DOCKER_COMPOSE) up -d --force-recreate nginx

wordpress:
	$(DOCKER_COMPOSE) build wordpress
	$(DOCKER_COMPOSE) up -d --force-recreate wordpress

static:
	$(DOCKER_COMPOSE) build static
	$(DOCKER_COMPOSE) up -d

.PHONY: all secrets up down clean fclean re nginx wordpress static
