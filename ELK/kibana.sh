#!/usr/bin/env bash
echo "<<<<<<<<< Installation Script Begin >>>>>>>>>>"
echo " "

echo "<<<<<<<< Install Java  >>>>>>>>>"

echo " "
echo "sudo apt-get update -y"
sudo apt-get update -y
echo " "

echo " "
echo "sudo apt-get install default-jre"
sudo apt-get install default-jre -y

echo " "
echo "sudo apt-get update -y"
sudo apt-get update -y
echo " "

echo " "
java -version | grep "java version"
echo " "

echo "<<<<<<<< Install Java Done >>>>>>>>>"
echo " "

echo "<<<<<<<<  Install Kibana     >>>>>>>>>"
echo " "
echo "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo "sudo apt-get install apt-transport-https"
sudo apt-get install apt-transport-https
echo " "

echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
echo " "

echo "sudo apt-get update -y"
sudo apt-get update -y
echo " "

echo "sudo apt-get -y install elasticsearch"
sudo apt-get -y install kibana
echo " "

echo "sudo service elasticsearch restart"
sudo service kibana start
echo " "

sudo update-rc.d elasticsearch defaults 96 9
echo " "

echo "sudo service elasticsearch status"
sudo service elasticsearch status
echo " "

echo "<<<<<<<<< Install Nginx >>>>>>>>>>"
echo " "
echo "sudo apt-get install nginx apache2-utils"
sudo apt-get install nginx apache2-utils
echo " "

echo "sudo htpasswd -c /etc/nginx/htpasswd.users kibanaadmin"
sudo htpasswd -c /etc/nginx/htpasswd.users kibanaadmin
echo " "
echo "sudo service nginx restart"
sudo service nginx restart

echo " "
echo "Install X-PACK for authentication"
echo "/usr/share/kibana/bin/kibana-plugin install x-pack"
echo " "
/usr/share/kibana/bin/kibana-plugin install x-pack
echo " "
echo "******** VAGRANT BOX (kibana) IP ADDRESS *********"
echo " "
ifconfig eth1 | grep "inet addr"
echo " "
echo "<<<<<<<<< Installation Script Ended >>>>>>>>>>"