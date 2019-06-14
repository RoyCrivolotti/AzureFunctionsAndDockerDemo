# AppToConsumeAzureFunctionsInContainerDemo

Azure Function App to consume: [this GitHub repo](https://github.com/RoyCrivolotti/ServerlessAppWithDocker)

This will be run inside its own container later, and from it it'll connect to the container where the Azure Function App is. For the time being though, I use `npm start` and enter through localhost.


The App that consumes this was run with:
```
docker build -t roycrivolotti/azurefunctionapp-docker-demo .
docker run -p 7071:80 roycrivolotti/azurefunctionapp-docker-demo
```
