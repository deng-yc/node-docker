FROM node
RUN mkdir /src
WORKDIR /src
ADD ./app/package.json ./package.json
COPY ./app/* ./
RUN npm install
