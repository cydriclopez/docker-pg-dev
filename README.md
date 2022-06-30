# docker-pg-dev

## Dockerize your PostgreSQL dev environment

>***This tutorial requires some knowledge in Linux, Docker, Git, and PostgreSQL.***

You can read the introduction of the previous tutorial [Dockerize your Angular dev environment](https://github.com/cydriclopez/docker-ng-dev) as it is fitting right here as well.

The pairing together of container and database was initially perceived with hesitance by database professionals because of the ephemeral state of containers. State persistence is a required attribute of databases even after the container is no more.

In the advent of the usage of durable massively scalable storage volumes, it is now de rigueur to house databases in containers.

For development purposes the pairing together of container and database is fitting. These days it makes a lot of sense to just download a self-contained complete database image rather than installing the database which in turn may require installing additional prerequisite software. You can even download different versions for the same database software to try out.

I recommend <ins>***using only Docker Official Images***</ins> to keep away from malicious codes and vulnerabilities. You can also use images from companies you trust.

The Docker official repository of images is located in [<ins>hub.docker.com</ins>](https://hub.docker.com/). Here you can search for the docker image you can download. This is the docker hub page for [Postgresql](https://hub.docker.com/_/postgres).

This tutorial is mostly about creating the Postgresql docker image and adding an alias command in the ***~/.bashrc*** file. It is actually a 3 step process I stretched into 7 for clarity. Installing Postgresql from you Linux distro's package system is quite straightforward but the version of Postgresql is usually old. Then you may have to install the database client as well. The server and client versions have to be closely matched or you may experience strange incompatibility problems. I like to think that this tutorial will make it easy to just create then run the Postgresql image.

**The key to using Docker in development is to bind mount your main project folder into a folder in the Docker image using the --volume or -v option. Once you have this mapping done then use the --workdir or -w option to declare this folder inside the Docker image as the working folder.**

In this tutorial we will talk about how to dockerize your PostgreSQL development environment.

The way I prefer to use Docker for Postgresql development purposes is to keep the image lean. To make it work takes 7 steps:

1. Git clone this project, then type ***cd docker-pg-dev/docker***
2. Build the image using the Dockerfile ***postgres.dockerfile***
3. Create your main Postgresql project folder with ***mkdir -p ~/Projects/psql***
4. Run image in detached mode by running bash script ***./postgres14***
5. Add 3 aliases your ~/.bashrc file as shown below
6. Reload your ~/.bashrc file with the command:   ***.   ~/.bashrc***

After step 6 you can run the alias command: ***pgstart***<br/>
Then type ***psql*** to run the client to connect to Postgresql.<br/>
To exit from the client type type ***\q***<br/>
To stop running the Postgresql server type ***pgstop***

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

# 3. Create your main Postgresql project working folder.
# You can create project sub-folders in this Postgresql project folder.
# mkdir -p ~/Projects/psql

# 4. While in the folder "docker-pg-dev/docker" run the script
# file "postgres14" by typing: ./postgres14

# This script will run the postgres image in detached mode, name it postgres14,
# create volume postgres_volume if not existing. This volume provides
# persistence when the container ceases running. It will also bind mount your
# project folder as the working folder.

# 5. Add these 3 aliases in ~/.bashrc
# alias pgstart='docker start postgres14'
# alias pgstop='docker stop postgres14'
# alias psql='docker exec -it postgres14 psql -U postgres'

# 6. Then reload ~/.bashrc by entering command: . ~/.bashrc

# After step #6. then you can type "psql" to connect to the database.
# To stop postgres14 type "pgstop".
# To start it again type "pgstart".

# To delete this postgres container:
# docker stop postgres14
# docker rm postgres14

# To delete the postgres image:
# docker rmi postgres

FROM postgres:latest
RUN mkdir -p /home/psql
```

---

### Some preliminaries for clarity

><ins>***Note that in the following command examples the colon ":" is part of my command-line prompt.</ins>
<br/>
<ins>You DO NOT type the colon ":" as part of the command.***</ins>
<br/>

Note that in Linux you can customize your command-line prompt. In my ***~/.bashrc*** file I have entered the following statement to customize my command-line prompt using the ***PS1*** environment variable.

```bash
export PS1=$PS1'\n:'
```

This statement in my ***~/.bashrc*** turns my command-line prompt into the following below. **This way no matter how long my current path is, my prompt starts at the leftmost part of my screen after the colon ":" character.**

```bash
user1@penguin:~/Projects/ng/my-app/node_modules/@angular/cli/src/commands/update/schematic$
:
```

So that you won't be typing ***sudo docker*** a lot, I suggest you run the following Linux Docker post install commands:

```
user1@penguin:~$
:sudo groupadd docker
:sudo usermod -aG docker $USER
```

Ok now that we have some clarity, let's get right to it. 😊

---

### 1. Git clone this project in a working folder
```
:git clone https://github.com/cydriclopez/docker-pg-dev.git
:cd docker-pg-dev/docker
```

### 2. Build the Postgresql image

Once inside the ***docker-pg-dev/docker*** folder build the Postgresql image using the command:
```
:docker build -f postgres.dockerfile -t postgres .
```

Note that there is a "dot" or a period "." at the end of this command. The period "." gives the current folder as context for the docker command. It tells docker where to find the docker file ***postgres.dockerfile***. Without the "-f" it looks for the default ***Dockerfile*** file. The "-t" names the docker image. So when we type the command "docker images" it lists the created image as "postgres".
```
:docker images
REPOSITORY   TAG            IMAGE ID       CREATED        SIZE
angular      latest         809901e9120f   17 hours ago   170MB
postgres     latest         6a3c44872108   4 months ago   374MB
node         14.18-alpine   194cd0d85d8a   5 months ago   118MB
```

Note that the ***postgres*** entry was generated by the previous ***docker build*** command.

The ***angular*** and ***node*** image entries were created in the previous tutorial [***Dockerizing your Postgresql dev environment***](https://github.com/cydriclopez/docker-ng-dev).

### 3. Create your main Postgresql project folder

In this example the main Postgresql project folder is ***~/Projects/psql***
So we type:
```
:mkdir -p ~/Projects/psql
```
In this project folder you can have several subfolders to house your multiple Postgresql projects.

### 4. Run the script file ***postgres14***

In the folder ***docker-pg-dev/docker*** there is a bash script file ***postgres14***. Below shows its listing.

```bash
:cat postgres14
#!/bin/bash
# This script will run the postgres image in detached mode, name it postgres14,
# and create volume postgres_volume if not existing. This volume provides
# persistence when the container ceases running. It will also bind mount your
# project folder as the working folder.
docker run -d --name=postgres14 -p 5432:5432 \
--mount source=postgres_volume,target=/var/lib/postgresql/data \
-v /home/user1/Projects/psql:/home/psql \
-w /home/psql \
-e POSTGRES_PASSWORD="my-postgres-password" postgres
```

The ***-d*** option runs the docker container in the background or detached mode. The ***--name=postgres14*** option names the running container ***postgres14***. The other parameters can be clarified by the following table.

### Table 1. Your host pc to Docker mappings table
|    | Your host pc | Docker |
| ----------- | --- | ----------- |
| postgresql port (-p) | 5432 | 5432 |
| docker volume (--mount) | postgres_volume | /var/lib/postgresql/data |
| volume mapping (-v) | /home/$USER/Projects/psql | /home/psql |
| working folder (-w) | (/home/$USER/Projects/psql) | /home/psql |
| environment variable (-e) |    | POSTGRES_PASSWORD=<br/>"my-postgres-password" |
| run docker image |    | postgres |

Run the script file ***postgres14*** by typing: ***./postgres14***

This script will run the postgres image in detached mode, name it ***postgres14***,
and create volume ***postgres_volume*** if not existing. This volume provides
database persistence when the container stops and then resume running. It will also bind mount your project folder as working folder.

Running the bash script file ***./postgres14*** returns the docker container id (64-character) ***UUID long identifier***. The command ***docker ps*** returns the shorter 12-character version ***UUID short identifier*** as shown below.

```bash
:./postgres14
ed0d2d87f67b5779d787c11df26f6f138b21156724bbe80ec1dc5a2e52dfe02a

:docker ps
CONTAINER ID   IMAGE      COMMAND                  CREATED              STATUS              PORTS                                       NAMES
ed0d2d87f67b   postgres   "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:5432->5432/tcp, :::5432->5432/tcp   postgres14
```

As shown above typing ***docker ps*** lists the container ***postgresql14*** as running.

### 5. Add these 3 aliases in ***~/.bashrc***

```bash
alias pgstart='docker start postgres14'
alias pgstop='docker stop postgres14'
alias psql='docker exec -it postgres14 psql -U postgres'
```

### Use your editor to add 3 alias commands ***pgstart***, ***pgstop***, and ***psql***

Use your code editor to edit your ***~/.bashrc*** file. In my case I enter the command:
```
:code ~/.bashrc
```

Then proceed to cut-and-paste those 3 aliases lines in the ***~/.bashrc*** file.

This is how it looks like in my code editor:<br/>
<img src="assets/images/vscode_add_3aliases.png" width="550"/>



---
