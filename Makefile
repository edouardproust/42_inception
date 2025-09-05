# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#   Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#   By: user <user@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/01 00:00:00 by user              #+#    #+#              #
#    Updated: 2023/01/01 00:00:00 by user             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all: up

build:
	@docker compose -f ./srcs/docker-compose.yml build

up:
	@docker compose -f ./srcs/docker-compose.yml up -d

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

start:
	@docker compose -f ./srcs/docker-compose.yml start

ps:
	@docker compose -f ./srcs/docker-compose.yml ps

logs:
	@docker compose -f ./srcs/docker-compose.yml logs

clean: down
	@docker system prune -a --force

fclean: clean
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true

re: fclean all

.PHONY: all build up down stop start ps logs clean fclean re
