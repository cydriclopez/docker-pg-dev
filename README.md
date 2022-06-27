# docker-pg-dev

## Dockerize your PostgreSQL dev environment

>This tutorial requires some knowledge in Linux, Docker, Git, and PostgreSQL.

You can read the introduction of the previous tutorial [Dockerize your Angular dev environment](https://github.com/cydriclopez/docker-ng-dev) as it is fitting right here as well.

The pairing together of container and database was initially perceived with hesitance by database professionals because of the ephemeral state of containers. State persistence is a required attribute of databases even after the container is no more.

In the advent of the usage of durable massively scalable storage volumes, it is now de rigueur to house databases in containers.

For development purposes the pairing together of container and database is fitting. These days it makes a lot of sense to just download a self-contained complete database image rather than installing the database which in turn may require installing additional prerequisite software. You can even download different versions for the same database software to try out.

I recommend <ins>***using only Docker Official Images***</ins> to keep away from malicious codes and vulnerabilities. You can also use images from companies you trust.

The Docker official repository of images is located in [<ins>hub.docker.com</ins>](https://hub.docker.com/). Here you can search for the docker image you can download. This is the docker hub page for [Postgresql](https://hub.docker.com/_/postgres).

This tutorial is mostly about creating the Postgresql docker image and adding an alias command in the ***~/.bashrc*** file. It is actually a 2 step process I stretched into 6 for clarity. Installing Postgresql from you Linux distro's package system is quite straightforward but the version of Postgresql is usually old. Then you may have to install the database client as well. The server and client versions have to be closely matched or you may experience strange incompatibility problems. I like to think that this tutorial will make it easy to just create then run the Postgresql image.

The key to using Docker in development is to bind mount your main project folder into a folder in the Docker image using the --volume or -v option. Once you have this mapping done then use the --workdir or -w option to declare this folder inside the Docker image as the working folder.

In this tutorial we will talk about how to dockerize your PostgreSQL development environment.

The way I prefer to use Docker for Postgresql development purposes is to keep the image lean. To make it work takes 6 steps:
1. Git clone this project, then type ***cd docker-ng-dev/docker***
2. Build the image using the Dockerfile ***angular.dockerfile***
3. Create your main Angular project folder with ***mkdir -p ~/Projects/ng***
4. Add an alias entry in your ~/.bashrc file as shown below
5. Reload your ~/.bashrc file with the command:   ***.   ~/.bashrc***

After step 5 you can run the alias command: ***angular***<br/>
You will now be in the Angular-Node container. To exit type ***exit***.

The docker file ***docker/postgres.dockerfile*** is fully commented.
```dockerfile
# postgres.dockerfile
# Dockerize your PostgreSQL dev environment

# So you won't be typing "sudo docker" a lot, suggested
# Linux Docker post install commands:
# sudo groupadd docker
# sudo usermod -aG docker $USER

# 1. After git cloning this project type: cd docker-pg-dev/docker
# 2. Build the Angular image using the command:
# docker build -f postgres.dockerfile -t postgres .

# 3.) Create the docker host volume
# docker volume create postgres-volume

# 4. Create your main Postgresql project working folder.
# You can create project sub-folders in this Postgresql project folder.
# mkdir -p ~/Projects/psql

# 5.) Run image in detached mode using volume from step 3 & working folder
# docker run -d --name=postgres14 -p 5432:5432 \
# -v postgres-volume:/var/lib/postgresql/data \
# -v /home/user1/Projects/psql:/home/psql \
# -w /home/psql \
# -e POSTGRES_PASSWORD="<set-postgres-password>" postgres

# 6.) Add these 3 aliases in ~/.bashrc
# alias pgstart='docker start postgres14'
# alias pgstop='docker stop postgres14'
# alias psql='docker exec -it postgres14 psql -U postgres'

# To remove this postgres image:
# docker stop postgres14
# docker rm postgres14

FROM postgres:latest
RUN mkdir -p /home/psql
```




---
