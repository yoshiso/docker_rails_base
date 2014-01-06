#!/bin/bash
#Install Ruby by rubyenv

if [ ! -d /usr/local/rbenv ];then
    cd /usr/local
    git clone git://github.com/sstephenson/rbenv.git rbenv
    mkdir rbenv/shims rbenv/versions rbenv/plugins
    git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

    # Setup rbenv for all user
    echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
    echo 'PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh

    # Install ruby
    rbenv install 2.0.0-p353
    rbenv rehash
    rbenv global 2.0.0-p353  # default ruby version

    #rbenv(add user to rbenv group if you want to use rbenv)
    useradd rbenv
    chown -R rbenv:rbenv rbenv
    chmod -R 775 rbenv

    # install withou ri,rdoc
    echo 'install: --no-ri --no-rdoc' >> /etc/.gemrc
    echo 'update: --no-ri --no-rdoc' >> /etc/.gemrc
    echo 'install: --no-ri --no-rdoc' >> /.gemrc
    echo 'update: --no-ri --no-rdoc' >> /.gemrc

    # install bundler
    gem install bundler
fi

#Install Node.js for Rails javascript runtime

if [ ! -d /usr/local/nvm ];then
    # install nvm
    git clone https://github.com/creationix/nvm.git /usr/local/nvm
    source /usr/local/nvm/nvm.sh

    # nvm(add user to nvm group if you want to use nvm)
    useradd nvm
    chown -R nvm:nvm /usr/local/nvm
    chmod -R 755 /usr/local/nvm
    nvm install 0.10.24

    # Setup rbenv for all user
    echo 'source /usr/local/nvm/nvm.sh' >> /etc/profile.d/nvm.sh
    echo 'nvm use v0.10.24' >> /etc/profile.d/nvm.sh
fi