FROM freekkalter/precise-vim
MAINTAINER Freek Kalter <freek@kalteronline.org>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://deb.torproject.org/torproject.org precise main" >> /etc/apt/sources.list
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -
RUN apt-get update

RUN apt-get install -y tor tor-arm sudo supervisor openssh-server
RUN apt-get -y upgrade

ADD torrc /etc/tor/torrc
EXPOSE 9001
EXPOSE 9030

RUN echo 'root:root' |chpasswd
RUN mkdir /var/run/sshd
EXPOSE 22

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
