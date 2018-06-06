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

echo "<<<<<<<<  Install Logstash     >>>>>>>>>"
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

echo "sudo apt-get -y install logstash"
sudo apt-get -y install logstash
echo " "

echo "sudo service logstash restart"
sudo service logstash restart
echo " "

#sudo update-rc.d logstash defaults 95 10
echo " "

echo "sudo service logstash status"
sudo service logstash status
echo " "

echo " "
echo "Install X-PACK for authentication"
echo "/usr/share/logstash/bin/logstash-plugin install x-pack"
echo " "
/usr/share/logstash/bin/logstash-plugin install x-pack
echo " "
echo "**************************** Filebeat Installation ****************************"
echo " curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-amd64.deb "
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-amd64.deb
echo " "
echo "sudo dpkg -i filebeat-6.2.4-amd64.deb"
sudo dpkg -i filebeat-6.2.4-amd64.deb
echo " "
echo "sudo service filebeat start"
sudo service filebeat start
echo " "
echo "******** VAGRANT BOX (logstash) IP ADDRESS *********"
echo " "
ifconfig eth1 | grep "inet addr"
echo " "

echo "<<<<<<<<< Installation Script Ended >>>>>>>>>>"