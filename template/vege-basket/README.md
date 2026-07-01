# Vege Basket

## Overview

Vege Basket is a personal project management workspace for organizing projects, journals, drafts, todos, risks, and AI-generated summaries.

This Sealos template deploys **Vege Basket** as the `vege-basket` application. It provisions the application workload, a PostgreSQL database, service discovery, and the public HTTPS entrypoint from the repository-maintained Sealos manifest.

## Deploy on Sealos

Open this template in the Sealos App Store, review the configuration values, and click **Deploy**. Sealos renders the template variables, creates the required Kubernetes resources, and manages the public endpoint for the application.

## Access

After deployment, open `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`. The concrete hostname is generated from `defaults.app_host` and your Sealos Cloud domain.

## Configuration

The following generated defaults are used during deployment:

- `app_host`: public hostname prefix for the application.
- `app_name`: Kubernetes resource name prefix for this deployment.
- `encryption_key`: generated 32-byte base64 key used by Vege Basket for application-level AES-256-GCM encryption.

The template stores data in a PostgreSQL database created by the deployment. Keep the generated encryption key stable for an existing deployment; if it is lost or changed, previously encrypted project data cannot be decrypted.

## Official Links

- Source repository: https://github.com/felixqiu014-wq/vege-basket
