# dind
docker-in-docker. A docker image that contains a static build of both the docker client and docker-compose.

## Usage

For any of the commands that do things with containers, you need to mount the docker socket, typically found at `/var/run/docker.sock`. As the user inside the container runs as root, it gets permissions on the docker socket by default. Running any command in a docker container as root (that has access to the underlying host) is a Bad Thing (tm). With that in mind, you should probably run the container using the correct UID & GID to access the socket. You can do this by passing the [`--user` flag](https://docs.docker.com/engine/reference/run/#user) at run time, as in the following examples.

### docker client

```
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock --user `id -u`:`stat -c %g /var/run/docker.sock` ls12styler/dind:latest docker ps
```

### docker-compose

```
docker run -it --rm -v `pwd`:/local -w /local -v /var/run/docker.sock:/var/run/docker.sock --user `id -u`:`stat -c %g /var/run/docker.sock` ls12styler/dind:latest docker-compose up
```
