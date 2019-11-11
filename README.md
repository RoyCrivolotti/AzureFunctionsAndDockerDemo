# AppToConsumeAzureFunctionsInContainerDemo

Azure Function App to consume: [this GitHub repo](https://github.com/RoyCrivolotti/ServerlessAppWithDocker)

To build and run this I run:
```
docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
docker run -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```
Accessed with **`localhost:3000`**


The App that consumes this was run with:
```
docker build -t roycrivolotti/azurefunctionapp-docker-demo .
docker run -p 7071:80 roycrivolotti/azurefunctionapp-docker-demo
```
**Important**: to run this, you need to create a .env file and in it create an IP environmental variable with your IP private IP address (192.168.x.xx) and the port: <ip>:<7071>. The port is 7071 simply because it is what I defined in the Dockerfile, but you can change that.

**Also**: you can just pull the images from Docker Hub:
- App that consumes the Azure Function App: `docker pull roycrivolotti/apptoconsumeazurefunctionsincontainer`
- Azure Function App `docker pull roycrivolotti/azurefunctionapp-docker-demo`

**Finally**

Note that the images used run comands assuming you are using a Linux/OS X machine with containers running on the host. If you are running this on a Windows machine with Docker or are using Windows Containers, you might have to make some modifications to the Dockerfiles and whatnot.

If you run this containers inside a Linux VirtualBox VM, for example, you'd have to check the IP of the azurefunctionapp-docker-demo container using docker network inspect bridge, and in the .env file use that IP, and for the port you should use 80 instead of 7071. The reason for this is that I didn't set this up using docker networks, instead I simply tell the containers which ports of the containers to connect to which ports of my host machine, and the container with the Node application consumes the app running on the other container by hitting the hosts IP with the proper port; however, you'd have to get the VM's IP to do this like that, which adds a bit of complexity, so instead you can just use the bridge network, to which the containers are connected by default.
