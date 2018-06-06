#!/usr/bin/env bash
echo "<<<<<<<<< Installation Script Begin >>>>>>>>>>"
echo ""
echo "<<<<<<<<<<< Install Java OpenJDK 7 >>>>>>>>>>>>"
echo ""

echo "sudo add-apt-repository ppa:openjdk-r/ppa"
sudo add-apt-repository ppa:openjdk-r/ppa
echo ""

echo "sudo apt-get install python-software-properties -y"
sudo apt-get install python-software-properties -y
echo ""

echo "sudo apt-get update -y"
sudo apt-get update -y
echo ""

echo "sudo apt-get install openjdk-7-jdk -y"
sudo apt-get install openjdk-7-jdk -y
echo ""

echo "<<<<<<<<<<< Java Installation Done. >>>>>>>>>>>>"
echo ""

echo "*************** Java Version ***************"
echo ""
java -version | grep "java version"
echo ""
echo "********************************************"

echo ""
echo "<<<<<<<< Install Java OpenJDK 7 Done >>>>>>>>>"
echo ""

echo "******** VAGRANT BOX IP ADDRESS *********"
echo ""
ifconfig eth1 | grep "inet addr"
echo ""
echo "*****************************************"
echo ""
echo "<<<<<<<<< Installation Script Ended >>>>>>>>>>"