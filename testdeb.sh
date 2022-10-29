#!/bin/bash

dpkg -i streambox-react-webui_*_all.deb

rm -f /dist/manifest-deb.txt

IFS='
'
for path in $(dpkg -L streambox-react-webui); do
    stat -c "%U:%G %a %A %n" "$path" >>/dist/manifest-deb.txt
done

sort -k2 manifest-deb.txt | cat -n

cnspec scan local --incognito -f cnspec.yaml -o full
