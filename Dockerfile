FROM node

RUN mkdir /src
WORKDIR /src
ADD ./app /src
ADD ./app/package.json /src/package.json
RUN npm install
