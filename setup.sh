#!/bin/bash
################
###general setup
################
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common unzip

##################
###setup terraform
##################
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

terraform --version

touch ~/.bashrc
terraform -install-autocomplete

################
###setup aws cli
################
gpg --import /vagrant/aws-cli.pub_key
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig" -o "awscliv2.sig"

if [ $(gpg --verify awscliv2.sig awscliv2.zip | grep "Good signature") -ne 0 ]; then
  echo "GPG verification failed for awscli"
  exit 1
fi

unzip awscliv2.zip
sudo ./aws/install
