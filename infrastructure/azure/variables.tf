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
