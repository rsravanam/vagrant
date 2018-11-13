echo "******************************************************* THE FOLLOWING WILL BE INSTALLED ************************************************************"
echo "****************************************************************************************************************************************************"
echo "******************************* apt-get update *********************************"

echo " "
sudo apt-get update -y
echo " "

echo "********************************************************************************"
echo "================================================================================"

echo "**************************************************************************************************************************************************"
echo "************************ curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh *********************"

echo " "
cd ~
sudo curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
echo " "

echo "**************************************************************************************************************************************************"
echo "=================================================================================================================================================="

echo "************************* sudo bash InstallHalyard.sh *******************************"

echo " "
cd ~
sudo bash InstallHalyard.sh
echo " "
echo "**************************************************************************************"
echo "======================================================================================"

echo "************************* hal -v *******************************"

echo " "
hal -v
echo " "
echo "****************************************************************"
echo "================================================================"

echo "************************* sudo update-halyard *******************************"

echo " "
sudo update-halyard
echo " "
echo "****************************************************************"
echo "================================================================"

echo "************************* . ~/.bashrc *******************************"

echo " "
. ~/.bashrc
echo " "
echo "*********************************************************************"
echo "====================================================================="



echo "************************* GLOUD SETUP *******************************"

echo " "
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
echo " "
echo "*********************************************************************"
echo "====================================================================="

echo "************************* SCRIPT *******************************"

echo " "
cat > ~/gcpcred.sh <<EOD

SERVICE_ACCOUNT_NAME=spinnaker-gce-account
SERVICE_ACCOUNT_DEST=~/.gcp/gce-account.json

gcloud iam service-accounts create \
    $SERVICE_ACCOUNT_NAME \
    --display-name $SERVICE_ACCOUNT_NAME

SA_EMAIL=$(gcloud iam service-accounts list \
    --filter="displayName:$SERVICE_ACCOUNT_NAME" \
    --format='value(email)')

PROJECT=$(gcloud info --format='value(config.project)')

# permission to create/modify instances in your project
gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$SA_EMAIL \
    --role roles/compute.instanceAdmin

# permission to create/modify network settings in your project
gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$SA_EMAIL \
    --role roles/compute.networkAdmin

# permission to create/modify firewall rules in your project
gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$SA_EMAIL \
    --role roles/compute.securityAdmin

# permission to create/modify images & disks in your project
gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$SA_EMAIL \
    --role roles/compute.storageAdmin

# permission to download service account keys in your project
# this is needed by packer to bake GCE images remotely
gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$SA_EMAIL \
    --role roles/iam.serviceAccountActor

mkdir -p $(dirname $SERVICE_ACCOUNT_DEST)

gcloud iam service-accounts keys create $SERVICE_ACCOUNT_DEST \
    --iam-account $SA_EMAIL

EOD


echo " "
echo "*********************************************************************"
echo "====================================================================="

echo "************************* SPINNAKER VAGRANT BOX IP ADDRESS *******************************"

echo " "
ifconfig | grep "inet addr"
echo " "
echo "******************************************************************************************"