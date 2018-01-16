FROM node

RUN mkdir /src

WORKDIR /src/app

COPY . /src

RUN npm install
