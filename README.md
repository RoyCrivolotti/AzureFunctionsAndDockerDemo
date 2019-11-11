# ServerlessAppWithDocker

App that consumes this: [this GitHub repo](https://github.com/RoyCrivolotti/AppToConsumeAzureFunctionsInContainerDemo)

To build and run this I run:

```
    docker network create --driver bridge isolated_nw
```

```
    docker build -t roycrivolotti/azurefunctionapp-docker-demo .
    docker run --network=isolated_nw --name serverlessapp roycrivolotti/azurefunctionapp-docker-demo
```

The App that consumes this API written with Azure Functions was run with:
```
    docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
    docker run --network=isolated_nw --name apptoconsume -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```
Accessed with **`localhost:3000`**: in the Dockerfile you can see that the `port 3000` is exposed so that one can access the application from the host machine.

**Important**: you can just pull the images from Docker Hub:
- App that consumes the Azure Function App: `docker pull roycrivolotti/apptoconsumeazurefunctionsincontainer`
- Azure Function App `docker pull roycrivolotti/azurefunctionapp-docker-demo`

**Finally**

Note that the images used here were tried only on two environments: a machine running OS X, first, and on a VirtualBox VM running Debian on a Windows laptop. If you use this on a different environment, such as non-Linux containers, some things might work differently -I never used Windows containers, so I don't really know much about it.
