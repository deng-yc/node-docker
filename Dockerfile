FROM node:6

RUN mkdir /src

WORKDIR /src

ADD app/package.json /src/package.json

RUN npm install

EXPOSE 8000

CMD node app/bin/www