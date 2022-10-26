version=$(perl -ne 'm{current_version.*= *([\d\.]+)} && print qq/$1/' .bumpversion.cfg)
deb=streambox-react-webui_${version}_all.deb
datestamp=$(date +%y-%m-%d)
mkdir -p React-${datestamp}
old=React-22-10-11.tar.gz
x1=$(echo $old | sed 's#.tar.gz##')
curl -O https://streambox-react-templates-app.s3-us-west-2.amazonaws.com/$old
tar xzf $old
find $x1 -type f ! -iname "*react*" | while read file; do cp $file React-${datestamp}; done
cp $deb React-${datestamp}
find React-${datestamp} -type f
tar czf React-${datestamp}.tar.gz React-${datestamp}
tar --list -f React-${datestamp}.tar.gz

aws s3 cp React-${datestamp}.tar.gz s3://streambox-react-templates-app/React-${datestamp}.tar.gz --acl public-read
echo https://streambox-react-templates-app.s3-us-west-2.amazonaws.com/React-${datestamp}.tar.gz | pbcopy
curl -I https://streambox-react-templates-app.s3-us-west-2.amazonaws.com/React-${datestamp}.tar.gz

cd /tmp
curl -O https://streambox-react-templates-app.s3-us-west-2.amazonaws.com/React-${datestamp}.tar.gz
rm -rf React-${datestamp}
tar xzf React-${datestamp}.tar.gz
rg --files React-${datestamp}

