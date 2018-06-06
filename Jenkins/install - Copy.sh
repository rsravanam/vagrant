#!/usr/bin/env bash
echo "<<<<<<<<< Installation Script Begin >>>>>>>>>>"
echo "<<<<<<<<< Adding apt repos >>>>>>>>>>"
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-add-repository ppa:ansible/ansible
echo "<<<<<<<<< Adding apt repos Done >>>>>>>>>>"
echo "<<<<<<<< Install Java OpenJDK 7 >>>>>>>>>"
sudo apt-get install python-software-properties -y
sudo apt-get update -y
sudo apt-get install openjdk-7-jdk -y
java -version
echo "<<<<<<<< Install Java OpenJDK 7 Done >>>>>>>>>"
echo "<<<<<<<<< Install Jenkins >>>>>>>>>>>"
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo 'deb https://pkg.jenkins.io/debian-stable binary/' | tee -a /etc/apt/sources.list
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo systemctl start jenkins
sudo netstat -plntu

sudo touch /etc/sudoers.d/jenkins
sudo cat > /etc/sudoers.d/jenkins <<EOD
jenkins ALL=(ALL:ALL) NOPASSWD:ALL
EOD

echo "<<<<<<<<< Install Jenkins Done >>>>>>>>>>>"

echo "<<<<<<<<< Install and configure Ansible >>>>>>>>>>>"
apt install ansible -y
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

echo "<<<<<<<<< Install and configure Ansible Done >>>>>>>>>>>"

echo "<<<<<<<<<<<<<<< DETAILS >>>>>>>>>>>>>>>>>>"

echo "******** VAGRANT BOX IP ADDRESS *********"
ifconfig eth1 | grep "inet addr"

echo "************ Jenkins Admin Password **************"
cat /var/lib/jenkins/secrets/initialAdminPassword
echo "**************************************************"

echo "<<<<<<<<<<< Virtualbox Installations >>>>>>>>>>>>>>"
sudo apt-get install linux-headers-$(uname -r) build-essential dkms -y
wget http://download.virtualbox.org/virtualbox/4.3.8/VBoxGuestAdditions_4.3.8.iso
sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions_4.3.8.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
sudo rm -f VBoxGuestAdditions_4.3.8.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
echo "<<<<<<<<< Installation Script Ended >>>>>>>>>>"