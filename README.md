# Ecommernce

This repository contains a complete Azure DevOps-based production-ready e-commerce application.

It includes:
- Node.js backend with a lightweight product storefront and API
- Docker image build for containerized deployment
- Azure Terraform infrastructure for AKS, ACR, and observability
- Kubernetes manifests with `kubenet` network mode and autoscaling
- Azure DevOps CI/CD pipeline for build, test, and deploy

## Repository structure

- `app/backend/` — Express application and Docker build artifacts
- `infrastructure/azure/` — Terraform configuration for Azure resources
- `k8s/` — Kubernetes manifests for deployment, service, autoscaling, ingress, and production configuration
- `azure-pipelines.yml` — Azure DevOps pipeline

## Quick start

1. Create an Azure DevOps service connection to your Azure subscription.
2. Configure pipeline variables in Azure DevOps:
   - `azureSubscription` — service connection name
   - `resourceGroupName`
   - `location`
   - `aksClusterName`
   - `acrName`
   - `acrConnection` — connection to Azure Container Registry
3. Push the repository to Azure DevOps and run the pipeline.

## Production-grade features

- Secure runtime headers with `helmet`
- Resource requests and limits for Kubernetes pods
- Health checks (liveness/readiness)
- Horizontal Pod Autoscaler
- AKS cluster autoscaling with `kubenet`
- Azure Container Registry for image storage
- Terraform-managed infrastructure with reusable inputs
- Namespace, ConfigMap and Secret support for environment configuration
