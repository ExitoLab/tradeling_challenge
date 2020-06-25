FROM node:12-alpine 

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY package*.json /home/node/app/

RUN cd /home/node/app && npm install --only=production

COPY . /home/node/app

RUN ls -la

EXPOSE 3000

CMD ["npm", "start"]
