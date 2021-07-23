#!/bin/bash

set -e
if [[ $(whoami) == "root" ]]; then
	MAKE_ME_ROOT=
else
	MAKE_ME_ROOT=sudo
fi

$MAKE_ME_ROOT docker -v
if [ $? -ne 0 ]; then
    curl -fsSL https://get.docker.com | bash -s docker
    if [ $? -ne 0 ]; then
        log_err "Install docker failed"
        exit 1
    fi
fi

$MAKE_ME_ROOT docker-compose -v
if [ $? -ne 0 ]; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    if [ $? -ne 0 ]; then
        log_err "Install docker-compose failed"
        exit 1
    fi
    $MAKE_ME_ROOT chmod +x /usr/local/bin/docker-compose
fi


echo "docker|docker-compose has been installed"