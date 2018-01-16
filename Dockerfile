FROM node
RUN mkdir /src
WORKDIR /src
COPY ./app /src
RUN npm install
