#!/bin/bash

URL=https://github.com/meetshah1995/config.git

local_test () {
    docker build config-docker -t config:latest
    docker run -v $HOME/.mconfig/:/.mconfig/ -it config:latest
}

remote_test () {
    docker build config-docker -t config:latest
    git clone "$URL" /tmp/mconfig
    docker run -v /tmp/mconfig/:/.mconfig/ -it config:latest
}

case $1 in
    --local )
        local_test;;
    --remote )
        remote_test;;
    *)
        echo "Only '--remote' and '--local' supported"
esac


