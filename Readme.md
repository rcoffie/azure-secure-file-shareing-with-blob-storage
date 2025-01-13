# Secure File Sharing System

This project provides a secure file sharing system using Terraform to manage infrastructure on Azure. It includes configurations for storage, Vault resources, and necessary providers.

## Overview

The system leverages Azure services to securely store and share files. Terraform is used to automate the deployment and management of the infrastructure.

## File Descriptions

- **.gitignore**: Specifies files and directories to be ignored by Git.
- **notes.md**: A markdown file for project notes.
- **terraform/**: Directory containing Terraform configuration files and state.

### Terraform Directory

- **.terraform/**: Directory containing Terraform provider plugins and modules.
- **.terraform.lock.hcl**: Lock file to ensure consistent provider versions.
- **main.tf**: Main Terraform configuration file.
- **output.tf**: Defines the outputs of the Terraform configuration.
- **storage.tf**: Terraform configuration for storage resources.
- **terraform.tfstate**: State file that keeps track of the resources managed by Terraform.
- **terraform.tfstate.backup**: Backup of the Terraform state file.
- **terraform.tfvars**: Variables file for Terraform configuration.
- **variable.tf**: Defines the input variables for the Terraform configuration.
- **vault.tf**: Terraform configuration for Vault resources.
- **version.tf**: Specifies the required Terraform version.

## Setup

1. **Clone the Repository**:
    ```sh
    git clone <repository-url>
    cd secure_file_sharing_system
    ```

2. **Initialize Terraform**:
    ```sh
    terraform init
    ```

3. **Review and Customize Variables**:
    Edit the `terraform.tfvars` file to customize the variables as per your requirements.

## Usage

1. **Plan the Infrastructure**:
    ```sh
    terraform plan
    ```

2. **Apply the Configuration**:
    ```sh
    terraform apply
    ```

3. **Destroy the Infrastructure**:
    ```sh
    terraform destroy
    ```

## Providers

- **azuread**: Azure Active Directory provider.
- **azurerm**: Azure Resource Manager provider.
- **local**: Local provider.
- **random**: Random provider.

## Notes

- Ensure you have the necessary permissions and credentials to manage the resources defined in the Terraform configuration.
- Review the `terraform.tfvars` file to customize the variables as per your requirements.

## License

This project is licensed under the MIT License.
