echo "******** THE FFOLLOWING WILL BE INSTALLED *********"
echo "***************************************************"
echo "**************** apt-get update *******************"

sudo apt-get update -y

echo "***************************************************"
echo "==================================================="

echo "******** VAGRANT BOX IP ADDRESS *********"
echo " "
ifconfig eth1 | grep "inet addr"