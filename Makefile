all: env up

env:
	@sh ./srcs/tools/make_env.sh

up:
	@cd ./srcs && docker compose up -d

down:
	@cd ./srcs && docker compose down

downv:
	@cd ./srcs && docker compose down -v

build:
	@cd ./srcs && docker compose build --no-cache	

re: downv env build up
