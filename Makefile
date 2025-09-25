DOCKER_COMPOSE = docker compose -f srcs/docker-compose.yml
STATIC_WEBSITE_PATH_ON_HOST = /home/${USER}/Sites/static
SECRETS_PATH = secrets
ENV_FILE = srcs/.env
TOOLS_PATH = srcs/requirements/tools
VOLUMES_PATH = /home/${USER}/data
WORDPRESS_VOLUME = $(VOLUMES_PATH)/wordpress
MARIADB_VOLUME = $(VOLUMES_PATH)/mariadb

all: secrets env volumes up

secrets:
	@$(TOOLS_PATH)/make_secrets.sh

env:
	@$(TOOLS_PATH)/make_env.sh

volumes:
	mkdir -p $(WORDPRESS_VOLUME)
	mkdir -p $(MARIADB_VOLUME)

up:
	
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down

clean:
	$(DOCKER_COMPOSE) down -v
	docker system prune -af

fclean: clean
	-docker stop $(shell docker ps -qa)
	-docker rm $(shell docker ps -qa)
	-docker rmi -f $(shell docker images -qa)
	-docker volume rm $(shell docker volume ls -q)
	-docker network rm $(shell docker network ls -q)
	sudo rm -rf $(WORDPRESS_VOLUME) $(MARIADB_VOLUME)
	rm -rf $(SECRETS_PATH)
	rm -f $(ENV_FILE)

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
	@echo "'make secrets': create 'secrets' folder and passwords files inside it"
	@echo "'make env': generate srcs/.env file based on files inside the 'secrets' folder"
	@echo "'make up': build images and start containers"
	@echo "'make down': stop containers"
	@echo "'make clean': stop and remove containers, remove images and volumes"
	@echo "'make fclean': same as 'make clean' + delete srcs/.env and secrets folder + rm volumes and networks of any other projects"
	@echo "'make re': equivalent of doing 'make clean' then 'make'"
	@echo "'make fre': equivalent of doing 'make fclean' then 'make'"
	@echo "'make nginx': clear and rebuild the 'nginx' container"
	@echo "'make wordpress': clear and rebuild the 'wordpress' container"
	@echo "'make static': clear and rebuild the 'static' container"
	@echo "'make help': get a list of available commands"

.PHONY: all secrets env volumes up down clean fclean re fre nginx wordpress static ftp help
