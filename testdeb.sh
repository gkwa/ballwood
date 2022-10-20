#!/bin/bash

dpkg -i streambox-react-webui_*_all.deb

rm -f /dist/manifest-deb.txt

IFS='
'
for path in $(dpkg -L streambox-react-webui); do
    stat -c "%U:%G %a %A %n" "$path" >>/dist/manifest-deb.txt
done

sort -k2 manifest-deb.txt | cat -n

ls -la /var/www/sbuiauth/logo
exit 0

find /var/local/WebData/logo -type f
ls -la /var/www/sbuiauth/logo
touch /var/www/sbuiauth/logo/test.txt
ls -la /var/local/WebData/logo/test.txt
