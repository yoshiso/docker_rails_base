# DOCKER-RAILS
#
# VERSION       1

FROM centos

MAINTAINER yoshiso

RUN yum -y update

#Dev tools for all Docker
RUN yum -y install git vim
RUN yum -y install passwd openssh openssh-server openssh-clients sudo

########################################## sshd ##############################################

# create user
RUN useradd yoshiso
RUN passwd -f -u yoshiso
RUN mkdir -p /home/yoshiso/.ssh;chown yoshiso /home/yoshiso/.ssh; chmod 700 /home/yoshiso/.ssh
ADD sshd/authorized_keys /home/yoshiso/.ssh/authorized_keys
RUN chown yoshiso /home/yoshiso/.ssh/authorized_keys;chmod 600 /home/yoshiso/.ssh/authorized_keys
# setup sudoers
RUN echo "yoshiso ALL=(ALL) ALL" >> /etc/sudoers.d/yoshiso
# setup sshd
ADD sshd/sshd_config /etc/ssh/sshd_config
RUN /etc/init.d/sshd start;/etc/init.d/sshd stop

#######################################  Supervisord  ########################################

RUN wget http://peak.telecommunity.com/dist/ez_setup.py;python ez_setup.py;easy_install distribute;
RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py;python get-pip.py;
RUN pip install supervisor

ADD supervisor/supervisord.conf /etc/supervisord.conf


#######################################   Ruby and Node Runtime  ########################################
# Installing Rails Runtime, Ruby and Node.js
RUN yum -y install gcc make zlib zlib-devel readline readline-devel openssl openssl-devel curl curl-devel
ADD install.sh install.sh
RUN chmod +x install.sh; ./install.sh;

RUN usermod -G yoshiso,rbenv,nvm yoshiso


###################################### Docker config #########################################


# expose for sshd

EXPOSE 2222

CMD ["/usr/bin/supervisord"]

