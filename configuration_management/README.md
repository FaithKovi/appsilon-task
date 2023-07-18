## Prerequisites
- Install [awscli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Install [Terraform](https://developer.hashicorp.com/terraform/downloads?ajs_aid=8edebcc0-620e-4d81-9f0e-029fa8433d7b&product_intent=terraform)

This directory contains all files for configuring and provisioning the project infrastructure

### Set Up Remote backend
Terraform remote backend stores state remotely
- Navigate to the `configuration_management/remote-backend` folder
```
cd configuration_management/remote-backend
```
Run the commands:
```
terraform init
terraform plan
terraform apply --auto-approve
```

### Set Up server
This sets up an EC2 virtual machine with Amazon Linux server distribution, installs ansible in on it and runs the provided playbook in `ansible/playbook.yml` which does the following:
- Creates a user with:
    - Username: john
    - Home: /better-place/john (create /better-place before if needed)
    - User ID: 1234
- Each new user have a script called nice-script.sh in their home directory
(hint: use "skeleton directory"). The script lists all mounted filesystems.

- The script is copied into the remote machine into the correct directory

- User john should be able to run the following command with sudo without a need
to provide his password: whoami
- Install packages:
    - Tmux
    - vim
-Install Terraform CLI
- Navigate to the `configuration_management/server` folder
```
cd configuration_management/server
```
Run the commands:
```
terraform init
terraform plan
terraform apply --auto-approve
```