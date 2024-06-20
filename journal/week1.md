# Week 1 — App Containerization

This week is tough to exactly get right, because this is my first time. I'm not exactly sure I got it right, actually.

Anyway, learning points:

1. To containerize the frontend and backend, you need to create a Dockerfile for each.
The frontend dockerfile should contain the base image (FROM node for react, vue and angular?), copy over whatever files are needed (COPY ./filename)(syntax COPY source destination), set work directories (WORKDIR /directorypath), install dependencies if needed (RUN pip install ...), set environment variables, build the frontend application (RUN npm install) and open the ports i intend to run on (EXPOSE port?) and run any commands needed (CMD[ ... ])
The backend dockerfile should contain the base image (FROM python:3.10-slim-buster for python), and largely similarly - copy, set workdir, install dependencies, set environment variables, run whatever files needed (RUN pip3 install -r requirements.txt), expose ports and state CMDs.

2. To link multiple containers, we need a docker-compose.yml file (which you run by running command docker-compose up). It should contain a version, services and networks. Under services,

```
services:
  backend-flask:
    environment: (set environment variables)
      FRONTEND_URL: "https://3000-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
      BACKEND_URL: "https://4567-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
    build: ./backend-flask (directory containing Dockerfile)
    ports: (maps host to container port)
      - "4567:4567"
    volumes: (mount the host directory to container)
      - ./backend-flask:/backend-flask
  frontend-react-js:
    environment:
      REACT_APP_BACKEND_URL: "https://4567-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
    build: ./frontend-react-js
    ports:
      - "3000:3000"
    volumes:
      - ./frontend-react-js:/frontend-react-js
```

3. To run these, you must first build then run the dockerfile. Build with: docker build -t backend-flask ./backend-flask, where -t is the tag, and ./backend-flask is the directory from which to look for the dockerfile. After that, we run 

docker run --rm -p 4567:4567 -it -e FRONTEND_URL='' -e BACKEND_URL='' backend-flask

where -p means match local:container and -it starts the container interactively. -e allows us to sub in values that are {}, and the last argument is the name of the Docker image to run as a container.
