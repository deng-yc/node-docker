FROM node:6

ENV HOME=/node_home

ENV NPM_CONFIG_LOGLEVEL warn

COPY ./app/package.json $HOME/

WORKDIR $HOME

RUN npm install

COPY ./app $HOME/

EXPOSE 8000

CMD ["npm", "start"]