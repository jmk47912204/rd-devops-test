FROM node:14.11.0-stretch

RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# This directoty will store cached files as specified in the config.json.
# If you haven't defined the cacheConfig.snapshotDir property you can remove the following line
RUN mkdir /cache

RUN git clone https://github.com/GoogleChrome/rendertron.git

WORKDIR /rendertron

RUN npm install && npm run build

# If you aren't using a custom config.json file you must remove the following line
#ADD config.json .

EXPOSE 3000

CMD ["npm", "run", "start"]
