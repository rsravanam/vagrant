echo "******** THE FFOLLOWING WILL BE INSTALLED *********"
echo "********************************************************************************"
echo "******************************* apt-get update *********************************"

echo " "
sudo apt-get update -y
echo " "

echo "********************************************************************************"
echo "================================================================================"

echo "*********************************************************************************"

echo "********************************************************************************"
echo "************************ install Minikube **************************************"

echo " "

echo "=================> Installing kubectl"

apt-get -qqy update && apt-get install -qqy apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubectl.list
apt-get update -qq
apt-get install -qqy kubectl


echo "Installing Docker"
sudo apt-get remove -qqy docker docker-engine docker.io
sudo apt-get install -qqy apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update -qqy
sudo apt-get install -yqq docker-ce
sudo usermod -aG docker vagrant
echo "Testing Docker Installation"
sudo docker run hello-world

echo "Downloading minikube"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.26.1/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

echo "Setting up and starting K8S"
sudo minikube start --vm-driver none
sudo chown -R vagrant:vagrant .kube
sudo chown -R vagrant:vagrant .minikube
minikube dashboard --url
kubectl cluster-info
echo " "

echo "*********************************************************************************"
echo "================================================================================"

echo "************************* VAGRANT BOX IP ADDRESS *******************************"

echo " "
ifconfig | grep "inet addr"
echo " "
echo "*********************************************************************************"