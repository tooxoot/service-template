FROM node:12 as builder

WORKDIR /app

FROM builder AS DEV

FROM builder as release
COPY . .
RUN chown -R node:node /app
RUN chmod -R 770 /app
USER node
RUN npm install
RUN npm run build
RUN rm -rf src

WORKDIR /app

EXPOSE 3000
CMD ["node", "/app/dist/index.js"]
