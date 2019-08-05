FROM node:10-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app

RUN yarn global add serve

USER node
COPY --chown=node:node . .
RUN yarn
RUN yarn build

EXPOSE 8080
CMD [ "serve", "-l", "8080", "-s", "dist" ]