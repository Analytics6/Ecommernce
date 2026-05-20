# Azure Infrastructure

This directory contains Terraform infrastructure for Azure resources used by the Ecommernce application.

## Included resources

- Azure Resource Group
- AKS cluster with `kubenet` networking and autoscaling
- Azure Container Registry (ACR)
- Log Analytics workspace + monitoring diagnostic settings
- Application Insights
- Azure SQL Server + database
- Azure Key Vault with secrets
- Storage account for Terraform state and persistent file storage
- Network Security Group and subnet for AKS
- Role assignments for ACR pull access
- Metric alerts and action group integration

## Deployment workflow

1. Configure `terraform.tfvars` or use `terraform.tfvars.example`.
2. If using a remote backend for the first time, initialize without backend, then apply:
   ```bash
   cd infrastructure/azure
   terraform init -backend=false
   terraform apply -auto-approve
   ```
3. After the backend storage account exists, reinitialize with backend:
   ```bash
   terraform init
   ```
4. Apply full infrastructure:
   ```bash
   terraform apply -auto-approve
   ```

## Variables

- `location` — Azure region
- `prefix` — naming prefix for all resources
- `resource_group_name` — resource group name
- `aks_cluster_name` — AKS cluster name
- `acr_name` — Azure Container Registry name
- `ssh_public_key` — SSH public key for AKS nodes
- `node_count`, `min_count`, `max_count` — AKS scaling settings
- `vm_size` — AKS node SKU
- `sql_admin_username`, `sql_admin_password` — SQL admin credentials
- `payment_provider_key` — secret API key for payment integration

## Notes

- The AKS cluster is configured with a managed identity and ACR pull permissions.
- The Key Vault stores database connection strings and payment provider secrets.
- Application Insights is provisioned for end-to-end telemetry.
- The `k8s/` directory contains Kubernetes manifests and a production overlay for deployment.
