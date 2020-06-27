FROM node:12-alpine 

RUN mkdir -p /home/node/app

WORKDIR /home/node/app

COPY package.json /home/node/app/

RUN cd /home/node/app && npm install --only=production && npm install nodemon

COPY . /home/node/app

ENV PORT=5000
ENV DATABASE_HOST=mongo
ENV DATABASE=tododb
ENV DB_PORT=27017

EXPOSE 5000

CMD ["npm", "start"]