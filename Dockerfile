FROM node

WORKDIR /src

RUN npm install

EXPOSE 8000

CMD node ./bin/www
