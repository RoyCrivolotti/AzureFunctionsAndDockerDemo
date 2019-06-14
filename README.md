# ServerlessAppWithDocker

App that consumes this: [this GitHub repo](https://github.com/RoyCrivolotti/ServerlessAppWithDocker)

To build and run this I run:
```
docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
docker run -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```

The Azure Function App on the other repo was run with:
```
docker build -t roycrivolotti/azurefunctionapp-docker-demo .
docker run -p 7071:80 roycrivolotti/azurefunctionapp-docker-demo
```
