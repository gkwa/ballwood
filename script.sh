dpkg -i /home/ubuntu/ballwood/streambox-react-webui_1.7.0_all.deb
usermod --shell /bin/bash www-data
echo www-data:www-data | chpasswd
rm -rf /var/local/WebData/templates
sudo -u www-data touch /var/www/sbuiauth/logo/trash.txt
sudo -u www-data rm -rf /var/www/sbuiauth/logo
sudo -u www-data rm -f /var/www/sbuiauth/logo/logo.jpg
sudo -u www-data find -H /var/www/sbuiauth/logo

cnspec scan local -f /home/ubuntu/ballwood/test.yaml --incognito -o full

cnspec
