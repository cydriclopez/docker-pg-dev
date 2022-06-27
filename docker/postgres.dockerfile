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

# 6.) Add these aliases in ~/.bashrc
# alias pgstart='docker start postgres14'
# alias pgstop='docker stop postgres14'
# alias psql='docker exec -it postgres14 psql -U postgres'

# To remove this postgres image:
# docker stop postgres14
# docker rm postgres14

FROM postgres:latest
RUN mkdir -p /home/psql
