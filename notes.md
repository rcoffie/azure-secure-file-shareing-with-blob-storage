# Project Documentation


## File Descriptions

- **.gitignore**: Specifies files and directories to be ignored by Git.
- **notes.md**: A markdown file for project notes (currently empty).
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

## Usage

1. **Initialize Terraform**:
    ```sh
    terraform init
    ```

2. **Plan the Infrastructure**:
    ```sh
    terraform plan
    ```

3. **Apply the Configuration**:
    ```sh
    terraform apply
    ```

4. **Destroy the Infrastructure**:
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
