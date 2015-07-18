FROM ruby:2.1.2
RUN apt-get update -qq && apt-get install -y build-essential

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
ADD . $APP_HOME
WORKDIR $APP_HOME
RUN RAILS_ENV=production

# # Install ngrok
# RUN apt-get install zip unzip
# RUN curl -Lk 'https://api.equinox.io/1/Applications/ap_pJSFC5wQYkAyI0FIVwKYs9h1hW/Updates/Asset/ngrok.zip?os=linux&arch=amd64&channel=stable' > ngrok.zip
# RUN unzip ngrok.zip -d /bin && rm -f ngrok.zip
# RUN echo 'inspect_addr: 0.0.0.0:3000' > /.ngrok
# # ENV HTTP_PORT 3000
# # ENV HTTPS_PORT 3000
# EXPOSE 3000
#
# #Add config script
# ADD ngrok_discover /bin/ngrok_discover
# RUN chmod +x /bin/ngrok_discover\

# RUN apt-get update && \
#   apt-get install -y npm && \
#   apt-get clean && \
#   rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
#   curl https://deb.nodesource.com/setup \
#   apt-get install nodejs
RUN apt-get update && \
    apt-get install -y npm && \
    apt-get install -y nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/nodejs /usr/bin/node
# ADD package.json /tmp/package.json
# RUN cd /tmp && npm install
# RUN mkdir -p /src && cp -a /tmp/node_modules /src/

RUN npm install -g localtunnel
# WORKDIR ../
# # CMD ["git clone git://github.com/defunctzombie/localtunnel-server.git ../localtunnel-server"]
# # WORKDIR localtunnel-server
# # RUN pwd
# # RUN npm install

# ADD package.json /src/package.json
# RUN cd /src && npm install
#RUN npm install

WORKDIR $APP_HOME
ADD server_scripts.sh /
CMD ["./server_scripts.sh"]
