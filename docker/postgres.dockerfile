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

# This script will run postgres image in detached mode, name it postgres14,
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
