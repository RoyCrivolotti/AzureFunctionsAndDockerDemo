FROM node:10

LABEL MAINTEINER="Roy Crivolotti"

ENV PORT=3000

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
RUN apt-get update
<<<<<<< HEAD
=======
# RUN apt-get upgrade -y
>>>>>>> 3c1ce7e99fcb962243660f0f111aa357a984cfd3
RUN apt-get install curl -y
COPY . .

EXPOSE $PORT

CMD ["npm", "start"]
