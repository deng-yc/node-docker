FROM node:6

RUN mkdir /node_home

WORKDIR /node_home

ADD app/package.json /node_home/package.json

RUN npm install

EXPOSE 8000

CMD ["npm", "start"]