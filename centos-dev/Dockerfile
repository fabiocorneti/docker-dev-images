FROM centos:7
MAINTAINER Fabio Corneti <info@corneti.com>

RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y \
      @development \
      sudo \
      gnupg \
      pcre-devel \
      zlib-devel \
      bzip2-devel \
      openssl-devel \
      ncurses-devel \
      sqlite-devel \
      readline-devel \
      tk-devel \
      gdbm-devel \
      db4-devel \
      libjpeg-devel \
      libpng-devel \
      libxslt-devel \
      freetype-devel && \
    yum clean all

