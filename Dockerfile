FROM node:11.13.0-alpine

RUN mkdir -p /codebase
WORKDIR /codebase
COPY ./codebase /codebase

RUN npm install \
    && npm run build

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=5000

CMD [ "npm", "start" ]