all: up

up:
	cd srcs && docker compose up -d

down:
	cd srcs && docker compose down

clean:
	cd srcs && docker compose down -v
	cd srcs && docker system prune -af

re: clean up
