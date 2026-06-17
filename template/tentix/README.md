# tentix

## Overview

A FastGPT-powered AI customer service platform with 10x accelerated resolution.

This Sealos template deploys **tentix** as the `tentix` application. It uses the repository-maintained Sealos manifest and keeps deployment, networking, and storage configuration inside the template.

## Included Dependencies

The default deployment provisions PostgreSQL `postgresql-14.8.0`, Sealos Object Storage, the Tentix migration container, the application Deployment, Service, Ingress, and App entry. Tentix requires the PostgreSQL `vector` extension; the migration preflight verifies that the target database provides it before running migrations.

The runtime images are expected to be available from the cluster registry as `sealos.hub:5000/limbo2342/tentix:dev-2025-10-23-x.3` and `sealos.hub:5000/limbo2342/tentix:migrate.10.22.x1`. The application image is checked before database migration starts, so missing image prerequisites block early instead of leaving a partially initialized instance.

On clusters where PostgreSQL only provides pgvector `0.5.0`, the newer `halfvec` type is unavailable. In that case the migration preflight logs a clear notice and skips only the optional halfvec IVFFlat acceleration index so the default application can still become ready. Clusters with a newer pgvector that provides `halfvec` keep the acceleration index.

This template does not require GPU resources. If a target cluster cannot provide PostgreSQL with the `vector` extension available, Sealos Object Storage credentials, or the mirrored Tentix images, deployment should be blocked before creating the application instance.

## Deploy on Sealos

Open this template in the Sealos App Store, review the configuration values, and click **Deploy**. Sealos renders the template variables, creates the required Kubernetes resources, and manages the public endpoint for the application.

## Access

After deployment, open `https://${{ defaults.domain }}.${{ SEALOS_CLOUD_DOMAIN }}`. The concrete hostname is generated from `defaults.domain` and your Sealos Cloud domain.

## Configuration

The following user-facing inputs are available during deployment:

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `OPENAI_API_KEY` | OpenAI API Key | `true` | `<redacted>` |
| `OPENAI_BASE_URL` | OpenAI endpoint base URL | `true` | `https://api.openai.com/v1` |

Keep sensitive values in Sealos-managed inputs or generated defaults. Do not commit private credentials to the template repository.

## Official Links

- Official website: https://github.com/labring/tentix
- Source repository: https://github.com/labring/tentix
