FROM node:12 as root

WORKDIR /app

FROM root AS dev


FROM root as build
COPY . .
RUN chown -R node:node /app
RUN chmod -R 770 /app
USER node
RUN npm install
RUN npm run build

FROM build as unittest
CMD [ "npm", "run",  "unittest" ]

FROM build as integrationtest
CMD [ "npm", "run", "integrationtest" ]

FROM build as release
RUN rm -rf src
RUN rm -rf dist/test

EXPOSE 3000
CMD ["node", "/app/dist/src/index.js"]
