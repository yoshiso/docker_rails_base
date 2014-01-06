#Docker-Rails-Base

Docker container recepi for using Rails application.

This Recipe is installed

* sshd
* supervisord
* rbenv ruby-2.0.0p-353
* nvm node.js v0.10.24


CentOS6.4, Docker 0.7.3

#Usage

```
git clone git@github.com:yss44/docker_supervisord.git
cd docker_supervisord
docker build yoshiso/supervisord .
docker run -p 2222 -p 80 -d yoshiso/supervisord
```

This Image is the base of rails application.
You can use this recipe's image as base image of Dockerfile like:

    From yoshiso/rails_base
