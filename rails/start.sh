#/bin/bash

cd /var/www/app;
bundle exec unicorn_rails -c /var/www/app/config/unicorn.rb -E production