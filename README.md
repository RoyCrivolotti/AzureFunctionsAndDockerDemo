# AppToConsumeAzureFunctionsInContainerDemo

Azure Function App to consume: [this GitHub repo](https://github.com/RoyCrivolotti/ServerlessAppWithDocker)

To build and run this I run:
```
docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
docker run -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```
The App that consumes this was run with:
```
docker build -t roycrivolotti/azurefunctionapp-docker-demo .
docker run -p 7071:80 roycrivolotti/azurefunctionapp-docker-demo
```

Accessed localhost:3000
