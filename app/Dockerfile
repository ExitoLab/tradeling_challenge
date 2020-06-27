FROM node:12-alpine 

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY package.json /home/node/app/

RUN cd /home/node/app && npm install --only=production && npm install nodemon

COPY . /home/node/app

EXPOSE 5000

CMD ["npm", "start"]