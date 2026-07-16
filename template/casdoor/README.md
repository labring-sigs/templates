# Casdoor

## Overview

Casdoor is a UI-first Identity Access Management (IAM) / Single-Sign-On (SSO) platform based on OAuth 2.0, OIDC, SAML and CAS.

This Sealos template deploys **Casdoor** as the `casdoor` application. It uses the repository-maintained Sealos manifest and keeps deployment, networking, and storage configuration inside the template.

## Deploy on Sealos

Open this template in the Sealos App Store, review the configuration values, and click **Deploy**. Sealos renders the template variables, creates the required Kubernetes resources, and manages the public endpoint for the application.

## Access

After deployment, open `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`. The concrete hostname is generated from `defaults.app_host` and your Sealos Cloud domain.

## Configuration

The following user-facing inputs are available during deployment:

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `driver_name` | Database driver name (postgres, mysql, sqlite) | `false` | `postgres` |

Keep sensitive values in Sealos-managed inputs or generated defaults. Do not commit private credentials to the template repository.

PostgreSQL is the recommended default for production deployments. SQLite is available for lightweight testing and stores its database on the Casdoor data volume.

## OIDC Redirect URLs

When Casdoor is used as an OIDC provider, each client application must define its own redirect URL in the Casdoor application settings. This value cannot be filled automatically by the Casdoor template because it depends on the external application domain.

For Outline, add this redirect URL:

```text
https://<your-outline-domain>/auth/oidc.callback
```

For example, if Outline is available at `https://outline-example.example.com`, the redirect URL is:

```text
https://outline-example.example.com/auth/oidc.callback
```

After saving the Casdoor application, copy its client ID and client secret into the client application, such as the Outline OIDC deployment inputs.

## Official Links

- Official website: https://casdoor.org/
- Source repository: https://github.com/casdoor/casdoor
