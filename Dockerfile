FROM node

RUN mkdir /src

ADD . /src

WORKDIR /src/app

RUN npm install

CMD ["npm","start"]
