# Twenty

## Overview

Open-source CRM alternative to Salesforce. Customizable views, flexible data management, workflow automation. Built with TypeScript, React, NestJS, PostgreSQL.

This Sealos template deploys **Twenty** as the `twenty` application. It uses the repository-maintained Sealos manifest and keeps deployment, networking, and storage configuration inside the template.

## Included Dependencies

The default deployment provisions all required runtime components:

- Twenty application server (`twentycrm/twenty:v1.12.0`)
- Twenty worker (`twentycrm/twenty:v1.12.0`)
- PostgreSQL 14.8.0 (KubeBlocks `postgresql-14.8.0`)
- Redis 7.0.6 (KubeBlocks `redis-7.0.6`)
- Persistent local file storage for the application server
- HTTPS ingress managed by Sealos

This template does not require GPU resources. The target Sealos cluster must provide the listed KubeBlocks cluster definitions and versions before deployment. If PostgreSQL 14.8.0 or Redis 7.0.6 is unavailable, the deployment should be blocked before creating the application instance instead of leaving a partially running instance.

## Deploy on Sealos

Open this template in the Sealos App Store, review the configuration values, and click **Deploy**. Sealos renders the template variables, creates the required Kubernetes resources, and manages the public endpoint for the application.

On first deployment, the application server can take several minutes to finish database-backed initialization before `/healthz` becomes ready. The template includes a startup probe for this cold-start window.

## Access

After deployment, open `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`. The concrete hostname is generated from `defaults.app_host` and your Sealos Cloud domain.

## Configuration

The following user-facing inputs are available during deployment:

This template does not define extra user inputs; the default settings are enough to deploy it.

Keep sensitive values in Sealos-managed inputs or generated defaults. Do not commit private credentials to the template repository.

## Troubleshooting

### Application pod is `Running 0/1` during startup

This can be normal for the first few minutes while Twenty initializes against PostgreSQL and Redis. Check the pod events and logs if it remains unready after the startup window.

### Database components fail to create

Confirm that the cluster has KubeBlocks PostgreSQL `postgresql-14.8.0` and Redis `redis-7.0.6` available. These are required dependencies for the default template.

## Official Links

- Official website: https://twenty.com
- Source repository: https://github.com/twentyhq/twenty
