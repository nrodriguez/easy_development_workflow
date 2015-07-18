#! /bin/bash

bundle exec rails s &
echo "RAILS RUNNING"
/usr/local/bin/lt --subdomain $CIRCLE_BRANCH --port 3000
