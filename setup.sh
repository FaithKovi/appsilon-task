#! /usr/bin/bash
set -e # stop if it fails at any point

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL="Prepare"
printf "${CYAN}====== ${LABEL}${NO_COLOR}\n"

aws configure

install terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

initialize s3
aws s3api create-bucket --bucket appsilon-terraform-state-bucket --region us-east-1 \
  --create-bucket-configuration LocationConstraint=us-east-1 \
  --versioning-configuration Status=Enabled



aws dynamodb create-table \
  --table-name appsilon-dynamodb-lock-table \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST