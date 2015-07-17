FROM ruby:2.1.2
RUN apt-get update -qq && apt-get install -y build-essential

# for capybara-webkit
RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

RUN bundle install
RUN gem list
ADD . $APP_HOME
