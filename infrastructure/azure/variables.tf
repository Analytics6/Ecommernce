variable "location" {
  description = "Azure region for deployment"
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "Resource prefix for naming"
  type        = string
  default     = "ecom"
}

variable "resource_group_name" {
  description = "Azure resource group name"
  type        = string
  default     = "ecom-rg"
}

variable "aks_cluster_name" {
  description = "AKS cluster name"
  type        = string
  default     = "ecom-aks"
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
  default     = "ecomregistry"
}

variable "ssh_public_key" {
  description = "SSH public key for AKS node pool"
  type        = string
  default     = ""
}

variable "node_count" {
  description = "Base node count for AKS"
  type        = number
  default     = 3
}

variable "min_count" {
  description = "Minimum node count for autoscaling"
  type        = number
  default     = 3
}

variable "max_count" {
  description = "Maximum node count for autoscaling"
  type        = number
  default     = 8
}

variable "vm_size" {
  description = "AKS node VM size"
  type        = string
  default     = "Standard_D4s_v3"
}

variable "storage_account_name" {
  description = "Storage account name for Terraform state and shared files"
  type        = string
  default     = "ecomterraformstate"
}

variable "storage_container_name" {
  description = "Storage container name for Terraform remote state"
  type        = string
  default     = "tfstate"
}

variable "sql_admin_username" {
  description = "SQL administrator login name"
  type        = string
  default     = "sqladminuser"
}

variable "sql_admin_password" {
  description = "SQL administrator password"
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
}

variable "payment_provider_key" {
  description = "Payment provider API key stored in Key Vault"
  type        = string
  default     = "REPLACE_WITH_SECURE_KEY"
  sensitive   = true
}
