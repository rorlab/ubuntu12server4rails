FROM ubuntu:12.04
MAINTAINER Lucius Choi <lucius.choi@gmail.com>

# `sudo` 패키지 설치
RUN apt-get install -y sudo

# 시스템 업데이트후 Git 설치하기
RUN sudo apt-get -y update

# install essentials
RUN apt-get -y install build-essential libssl-dev

RUN sudo apt-get -y install curl git-core python-software-properties

# 웹서버(Nginx) 설치하기
RUN sudo apt-get -y install nginx
RUN sudo service nginx start

# 서버용 자바스크립트 엔진(Nodejs) 설치하기
RUN sudo apt-get -y install nodejs

# 루비환경관리자(rbenv) 설치하기
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
RUN echo '# rbenv setup' > /etc/profile.d/rbenv.sh
RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN chmod +x /etc/profile.d/rbenv.sh

# install ruby-build
RUN mkdir /usr/local/rbenv/plugins
RUN git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

ENV RBENV_ROOT /usr/local/rbenv

ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# does not work. PATH is set to
# $RBENV_ROOT/shims:$RBENV_ROOT/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# install ruby2
RUN rbenv install 2.1.2
RUN rbenv global 2.1.2
RUN rbenv rehash
RUN gem install bundler --no-rdoc --no-ri
RUN gem install rails --no-rdoc --no-ri
RUN rbenv rehash