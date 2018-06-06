#!/usr/bin/env bash
echo "<<<<<<<<< Installation Script Begin >>>>>>>>>>"
echo " "
echo "<<<<<<<<< Adding apt repos >>>>>>>>>>"
echo " "
echo "sudo add-apt-repository ppa:openjdk-r/ppa"
sudo add-apt-repository ppa:openjdk-r/ppa
echo " "

echo "sudo apt-add-repository ppa:ansible/ansible"
sudo apt-add-repository ppa:ansible/ansible
echo " "
echo "<<<<<<<<< Adding apt repos Done >>>>>>>>>>"
echo " "

echo "<<<<<<<< Install Java OpenJDK 7 >>>>>>>>>"

echo " "
echo "sudo apt-get install python-software-properties -y"
sudo apt-get install python-software-properties -y

echo " "
echo "sudo apt-get update -y"
sudo apt-get update -y
echo " "

echo "sudo apt-get install openjdk-7-jdk -y"
sudo apt-get install openjdk-7-jdk -y

echo " "
java -version | grep "java version"
echo " "

echo "<<<<<<<< Install Java OpenJDK 7 Done >>>>>>>>>"
echo " "
echo "<<<<<<<<< Install Jenkins >>>>>>>>>>>"

echo " "
echo "wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

echo " "
echo "echo 'deb https://pkg.jenkins.io/debian-stable binary/' | tee -a /etc/apt/sources.list"
echo 'deb https://pkg.jenkins.io/debian-stable binary/' | tee -a /etc/apt/sources.list

echo " "
echo "sudo apt-get update -y"
sudo apt-get update -y

echo " "
"sudo apt-get install jenkins -y"
sudo apt-get install jenkins -y

echo " "
echo "Starting Jenkins..."
sudo systemctl start jenkins

echo " "
echo "Checking the Jenkins service port..."
sudo netstat -plntu | grep 8080

echo " "
sudo touch /etc/sudoers.d/jenkins
sudo cat > /etc/sudoers.d/jenkins <<EOD
jenkins ALL=(ALL:ALL) NOPASSWD:ALL
EOD

echo " "
echo "<<<<<<<<< Install Jenkins Done >>>>>>>>>>>"

echo " "
echo "<<<<<<<<< Install and configure Ansible >>>>>>>>>>>"
echo " "

echo "sudo apt-get install ansible -y"
sudo apt-get install ansible -y

echo " "
sudo touch /etc/ansible/hosts
sudo cat > /etc/ansible/hosts <<EOD
[group_name]
alias ansible_ssh_host=your_server_ip

[servers]
host1 ansible_ssh_host=192.0.2.1
host2 ansible_ssh_host=192.0.2.2
host3 ansible_ssh_host=192.0.2.3

EOD

sudo mkdir /etc/ansible/group_vars
sudo touch /etc/ansible/group_vars/servers

sudo cat > /etc/ansible/group_vars/servers <<EOD
---
ansible_ssh_user: root
ANSIBLE_HOST_KEY_CHECKING=False
EOD

export ANSIBLE_HOST_KEY_CHECKING=False

echo " "
echo "<<<<<<<<< Ansible Installation Done >>>>>>>>>>>"
echo " "

echo "<<<<<<<<<<<<<<< DETAILS >>>>>>>>>>>>>>>>>>"
echo " "

echo "******** VAGRANT BOX (jenkins_server) IP ADDRESS *********"
echo " "
ifconfig eth1 | grep "inet addr"
echo " "

echo "************ Jenkins initial Admin Password Password **************"
echo " "
cat /var/lib/jenkins/secrets/initialAdminPassword
echo " "
echo "********************************************************************"

echo " "

echo "<<<<<<<<< Installation Script Ended >>>>>>>>>>"