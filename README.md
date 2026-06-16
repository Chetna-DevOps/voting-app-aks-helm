# Voting App — Helm + Azure DevOps on AKS

This is a continuation of my [ArgoCD project](https://github.com/ChetnaPanday/voting-app-aks-argocd) where I deployed the same voting app but this time using Helm charts and Azure DevOps pipelines instead of plain manifests and ArgoCD.

## What's Different Here

- Plain k8s manifests replaced with Helm charts
- ArgoCD replaced with Azure DevOps CD pipelines
- Redis and PostgreSQL deployed using Bitnami Helm charts
- App deployed in `test` namespace instead of `default`

## Tech Stack

- **Vote frontend** — Python (Flask) — lets users vote between two options
- **Result frontend** — Node.js — shows live voting results
- **Worker** — C# (.NET) — consumes votes from Redis and stores in PostgreSQL
- **Queue** — Redis (Bitnami)
- **Database** — PostgreSQL (Bitnami)
- **Registry** — Azure Container Registry
- **Ingress** — NGINX on AKS
- **CD** — Azure DevOps Pipelines + Helm

## Project Structure

```
├── vote/
│   ├── charts/          # Helm chart
│   ├── app.py
│   └── Dockerfile
├── result/
│   ├── charts/          # Helm chart
│   └── ...
├── worker/
│   ├── charts/          # Helm chart (no ingress — internal service)
│   └── ...
└── .azure-pipelines/
    └── aks-deploy-helm-charts-via-acr/
        ├── infra-deploy-pipeline.yml
        ├── vote-deploy-pipeline.yml
        ├── result-deploy-pipeline.yml
        └── worker-deploy-pipeline.yml
```

## Pipelines

There are 4 pipelines — run infra first, then the rest in any order:

1. **infra** — deploys Redis and PostgreSQL via Bitnami charts (run once)
2. **vote** — builds image, pushes to ACR, deploys via Helm
3. **result** — same as above
4. **worker** — same as above

Each app pipeline pushes the image with `$(Build.BuildId)` as the tag and passes it to Helm on deploy so the exact build is always traceable.

## Setup

- Create variable group `ci-cd-variables` in Azure DevOps Library with: `containerregistryserviceconnection`, `acr_login_server`, `acr_username`, `acr_password`, `aksClusterName`, `resourceGroup`, `namespace`
- Replace `<ACR_LOGIN_SERVER>` and `<YOUR-CLUSTER-IP>` in each `values.yaml`
- Get ingress IP: `kubectl get svc -n ingress-nginx`
- Run infra pipeline first, then the app pipelines

## App URLs

```
http://vote.<CLUSTER-IP>.nip.io
http://result.<CLUSTER-IP>.nip.io
```

## Credits

Base application from [dockersamples/example-voting-app](https://github.com/dockersamples/example-voting-app).

## What I Did

- Wrote Helm charts for all three custom services
- Used Bitnami charts for Redis and PostgreSQL instead of writing them from scratch
- Set up separate Azure DevOps pipelines per service with build and deploy stages
- Kept worker chart without ingress since it's a background processor with no UI
- Used `$(Build.BuildId)` as image tag so each deployment is traceable to its build
