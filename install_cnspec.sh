#!/bin/bash

apt-get -qq update
apt-get -qqy install apache2

apt-get -qy install curl

version=$(curl --silent "https://api.github.com/repos/mondoohq/cnspec/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")' | tr -d v)
curl -sSLO https://github.com/mondoohq/cnspec/releases/download/v${version}/cnspec_${version}_linux_amd64.deb
dpkg -i cnspec_${version}_linux_amd64.deb
