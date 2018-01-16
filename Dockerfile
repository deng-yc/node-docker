FROM node
RUN mkdir /src
WORKDIR /src
ADD app/package.json /src/package.json
COPY ./app/* /src/
RUN npm install
