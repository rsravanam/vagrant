echo "******************************************************* THE FOLLOWING WILL BE INSTALLED ************************************************************"
echo "****************************************************************************************************************************************************"
echo "******************************* Install Python *********************************"
#http://web.mit.edu/6.00/www/handouts/pybuntu.html
echo " "
sudo add-apt-repository ppa:fkrull/deadsnakes
sudo apt-get update -y
sudo apt-get install python2.6 idle-python2.6
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.6 10
sudo update-alternatives --config python

#sudo update-alternatives --remove-all python
#sudo ln -s python3.1 /usr/bin/python

echo " "

echo "********************************************************************************"
echo "================================================================================"

echo "**************************************************************************************************************************************************"

echo "****************************************************************************************************************************************************"
echo "******************************* Install Ansible *********************************"
# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#intro-installation-guide
echo " "

sudo apt-get update -y
sudo apt-get install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y

echo " "

echo "********************************************************************************"
echo "================================================================================"

echo "**************************************************************************************************************************************************"


echo "************************* SPINNAKER VAGRANT BOX IP ADDRESS *******************************"

echo " "
ifconfig | grep "inet addr"
echo " "
echo "******************************************************************************************"