# docker-pg-dev

## Dockerize your PostgreSQL dev environment

>This tutorial requires some knowledge in Linux, Docker, Git, and PostgreSQL.

You can read the introduction of the previous tutorial [Dockerize your Angular dev environment](https://github.com/cydriclopez/docker-ng-dev) as it is fitting right here as well.

The pairing together of container and database was initially perceived with hesitance by database professionals because of the ephemeral state of containers. State persistence is a required attribute of databases even after the container is no more.

In the advent of the usage of durable massively scalable storage volumes, it is now de rigueur to house databases in containers.

For development purposes the pairing together of container and database is fitting. These days it makes a lot of sense to just download a self-contained complete database image rather than installing the database which in turn may require installing additional prerequisite software. You can even download different versions for the same database software to try out.

In this tutorial we will talk about how to dockerize your PostgreSQL development environment.




---
