# Kubernetes Deployment Structure

This directory contains a full production-style Kubernetes configuration using Kustomize.

## Structure

- `base/` — reusable manifest definitions for all environments
- `overlays/production/` — production-specific image and namespace configuration

## Deployment

Use the overlay to deploy the production configuration:

```bash
kubectl apply -k k8s/overlays/production
```

## Notes

- `ServiceAccount`, `Role`, and `RoleBinding` provide namespace-level least privilege.
- `NetworkPolicy` limits traffic inside the namespace.
- `HorizontalPodAutoscaler` enables CPU/memory-based scale-out.
- `PersistentVolumeClaim` is included to support stateful workloads or cache volumes.
