# Infrastructure Task Part 1

This repository contains solution to Part 1 of the Appsilon Infrastructure task (Containers + CI/CD + Configuration Management)

## Project structure
.
|-- README.md
|-- app
|   |-- Dockerfile
|   |-- app.py
|   |-- requirements.txt
|   `-- script.sh
|-- configuration_management
|   |-- ansible
|   |   |-- ansible.cfg
|   |   |-- nice-script.sh
|   |   `-- playbook.yml
|   |-- remote_backend
|   |   |-- main.tf
|   |   |-- outputs.tf
|   |   `-- providers.tf
|   `-- server
|       |-- backend.tf
|       |-- main.tf
|       |-- modules
|       |   `-- network
|       |       |-- main.tf
|       |       |-- outputs.tf
|       |       `-- variables.tf
|       |-- outputs.tf
|       |-- providers.tf
|       `-- variables.tf
`-- setup.sh

### Containers
- Application (Language/Framework): **Python/Flask**
- Container Technology: **Docker**
    - Uses Crossplatform image build with buildx
- CI/CD: **GitHub Actions**
    - Build trigger on push (to main) and schedule (Saturday, 7pm UTC)

### Configuration Management
- Infrastructure-as-Code: **Terraform**
    - Creates remote backend and also sets up server
- Configuration Management: **Ansible**
- Cloud: **AWS**
- Control Node: **Ubuntu 22.04**

