FROM node:14.15.4-alpine

ENV PORT=80

WORKDIR /app

COPY .npmrc app.js package.json package-lock.json /app/
COPY bin /app/bin/
COPY public /app/public/
COPY routes /app/routes/
COPY views /app/views/

RUN npm i

EXPOSE 80
CMD ["/usr/local/bin/npm", "run", "start"]
