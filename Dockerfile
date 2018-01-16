FROM node

RUN mkdir /src
WORKDIR /src
ADD . /src
RUN npm install
