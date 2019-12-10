FROM node:10

LABEL MAINTEINER="Roy Crivolotti"

ENV PORT=3000

WORKDIR /usr/src/app

RUN apt-get update && apt-get install curl -y

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE $PORT

CMD ["npm", "start"]
