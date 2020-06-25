FROM node:12-alpine 

WORKDIR /home/node/app

COPY package.json /home/node/app

RUN cd /home/node/app && npm install && npm cache clean --force --loglevel=error

COPY . .

EXPOSE 3000
CMD ["npm", "start"]