# ServerlessAppWithDocker

App that consumes this: [this GitHub repo](https://github.com/RoyCrivolotti/AppToConsumeAzureFunctionsInContainerDemo)

To build and run this I run:
```
docker build -t roycrivolotti/azurefunctionapp-docker-demo .
docker run -p 7071:80 roycrivolotti/azurefunctionapp-docker-demo
```
You can hit this app through you local private ip address and the port (i.e. `192.168.x.xx:7071/api/products/<specific-route>`)
If you try to hit it from Postman or from the browser without running the other app, you can also just use `localhost:7071.../api/products/<specific-route>`


The App that consumes this was run with:
```
docker build -t roycrivolotti/apptoconsumeazurefunctionsincontainer .
docker run -p 3000:3000 roycrivolotti/apptoconsumeazurefunctionsincontainer
```
Accessed with **`localhost:3000`**

**Important**: to run this, you need to create a **`.env`** file and in it create an **`IP`** environmental variable with your IP private IP address (`192.168.x.xx`).
