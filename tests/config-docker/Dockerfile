FROM ubuntu:18.04

ENV TERM xterm

ENV DEBIAN_FRONTEND noninteractive

RUN echo "91.189.92.201 archive.ubuntu.com" >> /etc/hosts

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    zsh \
    sudo \
    git \
    curl \
    ca-certificates \
    software-properties-common \
    python-pip \
    rxvt-unicode 

RUN pip install setuptools wheel

RUN exec zsh

RUN mkdir /root/.config/

WORKDIR /.mconfig/

CMD ["/bin/zsh", "install.sh", "server"]
