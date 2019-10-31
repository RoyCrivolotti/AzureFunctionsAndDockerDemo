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
**Important**: to run this, you need to create a **`.env`** file and in it create an **`IP`** environmental variable with your IP private IP address (`192.168.x.xx`).

**ALSO**: you can just pull the images from Docker Hub:
- App that consumes the Azure Function App: `docker pull roycrivolotti/apptoconsumeazurefunctionsincontainer`
- Azure Function App `docker pull roycrivolotti/azurefunctionapp-docker-demo`

**Finally**: note that the images used run comands assuming you are using a Linux VM. For Windows VM you'd have to make some modifications: for example, the paths would have to be aboslute, starting always from the C:\ position.
