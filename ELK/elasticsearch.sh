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

echo "<<<<<<<<  Install Elasticsearch     >>>>>>>>>"
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
sudo apt-get -y install elasticsearch
echo " "

echo "sudo service elasticsearch start"
sudo service elasticsearch start
echo " "

sudo update-rc.d elasticsearch defaults 95 10
echo " "

echo "sudo service elasticsearch status"
sudo service elasticsearch status
echo " "

echo "Install X-PACK for authentication"
echo "/usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack"
echo " "
/usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack
echo " "
echo "******** VAGRANT BOX (elasticsearch) IP ADDRESS *********"
echo " "
ifconfig eth1 | grep "inet addr"
echo " "
echo "<<<<<<<<< Installation Script Ended >>>>>>>>>>"