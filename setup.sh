#! /usr/bin/bash
set -e # stop if it fails at any point

CYAN='\033[1;36m'
NO_COLOR='\033[0m'
LABEL="Configuration Management Setup"
printf "${CYAN}====== ${LABEL}${NO_COLOR}\n"


echo "CREATE REMOTE BACKEND"
cd configuration_management/remote_backend
terraform init
terraform plan
terraform apply

echo "CREATE SERVER"
cd ..
cd server
terraform init
terraform plan
terraform apply