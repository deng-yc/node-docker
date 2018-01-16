FROM node

RUN mkdir /src

COPY . /src

WORKDIR /src/app

RUN npm install

CMD ["npm","start"]
