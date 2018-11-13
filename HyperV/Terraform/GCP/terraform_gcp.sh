echo " "
echo " "

echo "****************** THE FFOLLOWING WILL BE INSTALLED ***************************"

echo " "

echo "********************************************************************************"

echo " "

echo "******************************* apt-get update *********************************"

echo " "
sudo apt-get update -y
echo " "

echo "******************************* Install unzip *********************************"

echo " "
echo "sudo apt-get install unzip"
echo " "
sudo apt-get install unzip
echo " "

echo "******************************* Download latest version of the terraform *********************************"

echo " "
wget https://releases.hashicorp.com/terraform/0.11.1/terraform_0.11.1_linux_amd64.zip -O /home/vagrant/terraform_0.11.1_linux_amd64.zip
chmod 777 /home/vagrant/terraform_0.11.1_linux_amd64.zip
echo " "

echo "******************************* unzip terraform_0.11.1_linux_amd64.zip *********************************"

echo " "
sudo unzip /home/vagrant/terraform_0.11.1_linux_amd64.zip
echo " "

echo "******************************* Move the executable into a directory searched for executables *********************************"

echo " "
sudo mv /home/vagrant/terraform /usr/local/bin/
echo " "

echo "******************************* GCP Command Line Installtion *********************************"

echo " "

# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# "Import the Google Cloud Platform public key"
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "*********************** Update the package list and install the Cloud SDK *****************************"

echo " "
sudo apt-get update -y && sudo apt-get install google-cloud-sdk -y
echo " "
	
echo "******************************* Git Installation *********************************"

echo " "
apt-get install git-core
echo " "

echo "******************************* Gcloud Installation Check *********************************"

echo " "
gcloud info
echo " "

echo "******************************* Terraform Installation Check *********************************"

echo " "
terraform --version
echo " "

echo "******************************* Git Installation Check *********************************"

echo " "
git --version
echo " "



echo "=========================================================================================="

echo "************************* TERRAFORM VAGRANT BOX IP ADDRESS *******************************"

echo " "
ifconfig | grep "inet addr"
echo " "
echo "******************************************************************************************"

echo "***************************** Installation Completed *************************************"