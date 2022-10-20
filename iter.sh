#!/bin/bash

lxc rm --force ub
lxc copy myubuntu/myubuntu-snap ub
lxc start ub

cat >test.sh <<EOF
dpkg -i /home/ubuntu/ballwood/streambox-react-webui_1.7.0_all.deb
cnspec scan local --incognito -f /home/ubuntu/ballwood/test.yaml -o full
EOF

lxc exec ub -- bash -x /home/ubuntu/ballwood/test.sh
