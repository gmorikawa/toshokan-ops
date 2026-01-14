# toshokan-ops

This project contains the `docker-compose` file to help setup a development environment on Docker, by providing three containers:

* `database`: a Postgres instance.
* `server`: the backbones and REST API for the `toshokan` system.
* `web`: client front-end application that consumes the REST API.

## Getting Started

### Setup `data` directory

I am using a `makefile` to organize the main commands necessary to setup a environment on Docker.

First execute `make init` to initialize the required `data` folder, which should be used by Docker create bind mounts for all containers.

```bash
make init
```

### Setting `data` folder manually

In case it is desired to set a different folder to bind mounts, you can change it on `docker-compose.yaml`. By opening this file, you should find a `volumes:` section:

```yaml
volumes:
  toshokan_server_mnt:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ./data/server # directory to bind mount for server container
  toshokan_database_mnt:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: ./data/postgres # directory to bind mount for database container
  toshokan_web_mnt:
```

If you decide to keep in this configuration, create a directory called `data` at the root of this project, then create two subdirectories: `postgres` and `server`. Ensure that those directories are accessible by users on `docker` group.

### Start containers

Run command `make container-up` to create and start the necessary containers. Since this operation requires also the _Server_ and _Web_ projects, you must have _toshokan_, _toshokan-web_ and _toshokan-ops_ under the same directory.

If necessary to change this behaviour, change the `docker-compose.yaml` file under `services:` section to reflect the location of the necessary repositories:

```yaml
services:
  server:
    build: ../toshokan # location of the server-application repository
    ...

  web:
    build: ../toshokan-web # location of web-application repository
    ...
```

### Stop containers

Run command `make container-down` to stop all containers.

If necessary, there is also the commands `remove-server-image` and `remove-web-image`, both to delete the built images from _server_ and _web_ repositories respectively. This operation is required to update the container in case of a update.

* I understand that a better solution exists, but for now this is not my focus.

## Future implementations

Since this is a study project, in the future I want to try to use other tools to manage containerization and deployment: like using `Podman` for example.

## 