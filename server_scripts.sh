#! /bin/bash

bundle exec rails s &
echo "RAILS RUNNING"
/usr/local/bin/lt --port 3000
