# inception

## Docker Cheatsheet (Step-by-Step Usage)

This cheatsheet is structured around typical workflow steps: Images → Create → Run → Attach/Start → Cleanup.

---

### 1️⃣ Images

| Command | Description | Example |
|---------|------------|---------|
| `docker images` | List all images | `docker images` |
| `docker build [-t <name[:tag>]] <context>` | Build an image from a Dockerfile | `docker build -t myapp:1.0 .` |
| `docker tag <ID\|prev_name> <new_name[:tag]>` | Name an image (if `-t` not used in `docker build`) or rename it | `docker tag d1b6 myapp:1.0` or `docker tag ubuntu:latest myubuntu:0.1` |
| `docker rmi <name[:tag]\|ID>` | Remove an image | `docker rmi myapp:1.0` or `docker rmi d1b6` |

other:

- |`docker pull` | Pull an image from a registry | `docker pull ubuntu:latest` |
- | `docker push` | Push an image to a registry | `docker push myrepo/myapp:1.0` |

---

### 2️⃣ Containers - Creation & Startup

| Command | Description | Example |
|---------|------------|---------|
| `docker create [--name <name>] <image>` | Create a container | `docker create --name mycontainer ubuntu:latest` or `docker container create ubuntu:latest`|
| `docker start <name\|ID>` | Start a container | `docker start mycontainer` or `docker container start d1b6` |
| `docker start -ai <name\|ID>` | Start a container and attach it in interactive mode | `docker start -ai mycontainer` |
| `docker run [--name <name>] <image>` | Create, run, start a container and print on terminal (attached mode): `docker create` + `docker start` + `docker attach` | `docker run --name mycontainer ubuntu:latest` |
| `docker run -d [--name <name>] <image>` | Create, run and start in the background (detached mode): `docker create` + `docker start` | `docker run -d --name mycontainer ubuntu:latest sleep 3600` |
| `docker run -it [--name <name>] <image>` | Run in interactive mode: `docker create` + `docker start -ai` | `docker run -it --name mycontainer ubuntu:latest` |

---

### 3️⃣ Interacting With Containers

| Command | Description | Example |
|---------|------------|---------|
| `docker exec -it <name> <command>` | Run a command in a running container interactively | `docker exec -it mycontainer bash` |
| `docker attach <name>` | Attach to a running container | `docker attach mycontainer` |
| `docker logs <name>` | Show container logs | `docker logs mycontainer` |
| `docker stop <name>` | Stop a running container | `docker stop mycontainer` |
| `docker restart <name\|ID>` | Restart a container | `docker restart mycontainer` or `docker restart d1b6`|
| `docker rename <prev_name> <new_name>` | Rename a container | `docker rename d1b6 mycontainer` or `docker rename mycontainer newname`|
| `docker ps` | List running containers | `docker ps` |
| `docker ps -a` | List all containers | `docker ps -a` |

---

### 4️⃣ Volumes

| Command | Description | Example |
|---------|------------|---------|
| `docker volume create` | Create a volume | `docker volume create myvolume` |
| `docker volume ls` | List volumes | `docker volume ls` |
| `docker volume inspect` | Inspect a volume | `docker volume inspect myvolume` |
| `docker volume rm` | Remove a volume | `docker volume rm myvolume` |

---

### 5️⃣ System & Cleanup

| Command | Description | Example |
|---------|------------|---------|
| `docker system df` | Show disk usage | `docker system df` |
| `docker container prune` | Remove all stopped containers | `docker container prune` |
| `docker image prune -a` | Remove unused images | `docker image prune -a` |
| `docker system prune -a` | Remove unused containers, images, volumes, networks | `docker system prune -a` |

---

### 6️⃣ Misc / Info

| Command | Description | Example |
|---------|------------|---------|
| `docker version` | Show Docker version | `docker version` |
| `docker info` | Show system-wide info | `docker info` |
| `docker inspect` | Inspect container or image | `docker inspect mycontainer` |
| `docker diff` | Show filesystem changes in a container | `docker diff mycontainer` |
