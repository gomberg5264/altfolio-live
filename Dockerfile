FROM node:alpine

WORKDIR /app

ENV NODE_ENV="production"

COPY package.json yarn.lock ./

RUN apk add --no-cache git && \
    yarn install --production && \
    yarn cache clean && \
    rm -rf /var/cache/* /tmp/* /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/yarn && \
    adduser -S nodejs && \
    chown -R nodejs /app && \
    chown -R nodejs /home/nodejs

USER nodejs

COPY . /app

CMD ["node", "api/api.js"]
