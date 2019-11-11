# ServerlessAppWithDocker

App that consumes this: [this GitHub repo](https://github.com/RoyCrivolotti/AppToConsumeAzureFunctionsInContainerDemo)

First we create the network

```
    docker network create --driver bridge isolated_nw
```

Then we build and run the Azure Function App

```
    docker build -t roycrivolotti/azurefunctionapp-docker-demo .
    docker run --network=isolated_nw --name serverlessapp roycrivolotti/azurefunctionapp-docker-demo
```

Finally, we run the container which has the app that consumes this API:

```
    docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
    docker run --network=isolated_nw --name apptoconsume -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```

We access the application with **`localhost:3000`**: in the Dockerfile you can see that the `port 3000` is exposed so that one can access the application from the host machine.

**Important**: you can just pull the images from Docker Hub:
- App that consumes the Azure Function App: `docker pull roycrivolotti/apptoconsumeazurefunctionsincontainer`
- Azure Function App `docker pull roycrivolotti/azurefunctionapp-docker-demo`

**Finally**

Note that the images used here were tried only on two environments: a machine running OS X, first, and on a VirtualBox VM running Debian on a Windows laptop. If you use this on a different environment, such as non-Linux containers, some things might work differently -I never used Windows containers, so I don't really know much about it.
