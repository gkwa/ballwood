#!/bin/bash

rpm -Uvh streambox_react_webui-*.noarch.rpm
rpm -qlp streambox_react_webui-*.noarch.rpm >/dist/manifest-rpm.txt
