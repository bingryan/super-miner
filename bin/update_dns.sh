#! /usr/bin/env bash

set -e

update_dns() {
	sed -ri '/^DNS=/d;/#DNS=/a DNS=8.8.8.8 114.114.114.114' /etc/systemd/resolved.conf
	systemctl enable systemd-resolved
	systemctl restart systemd-resolved
	mv /etc/resolv.conf /etc/resolv.conf.bak
	ln -s /run/systemd/resolve/resolv.conf /etc/
}


update_dns
