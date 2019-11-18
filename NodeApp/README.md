# Node demo app

Very basic front-end using pug. The Node app being created and run here is very basic. I did try to be organized though, separating the views, routes and controllers into their own files and directories.

The Azure Functions app is referenced by its container name, so as to avoid dealing with IPs. This works because both containers are placed in the same user-defined Bridge network.

At the same time, we can access the Node app from the host machine because in the Dockerfile we expose `port 3000`.
