#!/bin/bash

dpkg -i streambox-react-webui_*_all.deb
dpkg -L streambox-react-webui >/dist/manifest-deb.txt
