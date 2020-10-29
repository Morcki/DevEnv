# DevEnv
Build Development Enviroment Through DockerFile

## PURE COMMAND

### How to Build Image

Step into the path where dockerfile locates, and just run the following command.
```
	docker build -t {IMAGE_NAME}:{IMAGE_VERSION} .
```

### How to Build Container

Use `docker images` to check out if you have builded your image correctly.
then input the following command to build a container based on your image.
```
	docker run -itv {LOCAL_FILEFOLDER}:{CONTAINER_FILEFOLDER} -p {FREE_PORT}:22 (-d) {IMAGE_NAME}:{IMAGE_VERSION} /bin/bash
```

## USE devcontrainer.json

### need vscode-plugin : remote-container

1. Open Dockerfile in vscode.Click right mouse and choose Build Image...
2. Fill settings in devcontainer.json and reopen in container.

## USE docker-compose

Touch docker-compose.yml and input your settings, then run the following command
```
	docker-compose up (-d)
```