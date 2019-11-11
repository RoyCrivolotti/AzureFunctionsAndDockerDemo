# AppToConsumeAzureFunctionsInContainerDemo

Azure Function App to consume: [this GitHub repo](https://github.com/RoyCrivolotti/ServerlessAppWithDocker)

To build and run this I run:

```
    docker network create --driver bridge isolated_nw
```

```
    docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
    docker run --network=isolated_nw --name apptoconsume -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```
Accessed with **`localhost:3000`**: in the Dockerfile you can see that the `port 3000` is exposed so that one can access the application from the host machine.

The Node app in the container started above consumes an Azure Function app as an API -this API is meant to be running in another container:
```
    docker build -t roycrivolotti/azurefunctionapp-docker-demo .
    docker run --network=isolated_nw --name serverlessapp roycrivolotti/azurefunctionapp-docker-demo
```

**Important**: you can just pull the images from Docker Hub:
- App that consumes the Azure Function App: `docker pull roycrivolotti/apptoconsumeazurefunctionsincontainer`
- Azure Function App `docker pull roycrivolotti/azurefunctionapp-docker-demo`

**Finally**

Note that the images used here were tried only on two environments: a machine running OS X, first, and on a VirtualBox VM running Debian on a Windows laptop. If you use this on a different environment, such as non-Linux containers, some things might work differently -I never used Windows containers, so I don't really know much about it.
