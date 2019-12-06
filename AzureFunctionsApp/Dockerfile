FROM microsoft/dotnet:2.2-sdk AS installer-env

LABEL MAINTEINER="Roy Crivolotti"

COPY . /src/dotnet-function-app
RUN cd /src/dotnet-function-app && \
    mkdir -p /home/site/wwwroot && \
    dotnet publish *.csproj --output /home/site/wwwroot

FROM mcr.microsoft.com/azure-functions/dotnet:2.0
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

#* The port 80 has to be exposed when deploying with Kubernetes
#* When running this locally with docker/docker-compose this shouldn't be exposed
#* since you shouldn't be able to access this service as a client
#* On the cloud, even if the port is exposed, the service that fronts this doesn't provide an external IP
#? EXPOSE 80

COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]