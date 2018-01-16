FROM node

RUN mkdir /src
WORKDIR /src
ADD ./app /src
RUN npm install
