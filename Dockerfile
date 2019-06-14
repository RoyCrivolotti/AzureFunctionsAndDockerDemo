FROM node:10
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
RUN apt-get update
RUN apt-get -y install curl
COPY . .
CMD ["npm", "start"]
