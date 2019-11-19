# AzureFunctionsAndDockerDemo

In this repo there are two demo applications: An Azure Functions app, and a Node app which consumes the former. The Azure Functions app has a static list which simulates a DB; when the Node app consumes its endpoints, it gets data as a response...

When I wrote this I was just trying to learn what Docker was and how to start using it, so this small demo was enough as a first demo. It was also my first time using Azure Functions..

## How to use this?

Well, initially I did it without Docker Compose, since *it was* my first demo. I'll document the Docker Compose after I explain how I run it manually...

## Without Docker Compose

First we create the network

```
    docker network create --driver bridge docker-demo-nw
```

Then we build and run the Azure Function App

```
    docker build -t roycrivolotti/azurefunctionsapp-docker-demo ./AzureFunctionsApp
    docker run --network=docker-demo-nw --name serverlessapp roycrivolotti/azurefunctionsapp-docker-demo
```

Finally, we build and run the container which has the Node app that consumes the Azure Functions app:

```
    docker build -t roycrivolotti/nodeapp ./NodeApp
    docker run --network=docker-demo-nw --name nodeapp -p 3000:3000 roycrivolotti/nodeapp
```

We access the application with **`localhost:3000`**: in the Node app's Dockerfile you can see that the `port 3000` is exposed so that one can access the application from the host machine.

## With Docker Compose

The following should be enough: `docker-compose up`

Since I use a static list and there is no persistence method, if you `stop` a container and `start` it again, the data you added or modified won't be there anymore; instead, the list will be the same as it was initially.

**Important**

Note that the images used here were tried only on two environments: a machine running OS X, first, and on a VirtualBox VM running Debian on a Windows laptop. If you use this on a different environment, such as non-Linux containers, some things might work differently -I never used Windows containers, so I don't really know much about them.
