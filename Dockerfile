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

RUN apt-get update && \
    apt-get install -y npm && \
    apt-get install -y nodejs --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g localtunnel

WORKDIR $APP_HOME
ADD server_scripts.sh /
CMD ["./server_scripts.sh"]
