# ServerlessAppWithDocker

App that consumes this: [this GitHub repo](https://github.com/RoyCrivolotti/AppToConsumeAzureFunctionsInContainerDemo)

To build and run this I run:
```
docker build -t roycrivolotti/azurefunctionapp-docker-demo .
docker run -p 7071:80 roycrivolotti/azurefunctionapp-docker-demo
```

The App that consumes this will be run inside its own container later, and from it'll connect to the container where the Azure Function App is. For the time being though, I use npm start and enter through localhost.

Accessed the endpoints with `localhost/ip:7071/api/<route>`
