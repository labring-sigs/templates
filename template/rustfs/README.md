# RustFS

## Overview

RustFS is a high-performance, S3-compatible object storage system built with Rust, offering distributed storage capabilities with multiple volume support.

This Sealos template deploys **RustFS** as a 4-node high-availability application. Each RustFS Pod owns one data PVC and participates in the same distributed volume set.

## Deploy on Sealos

Open this template in the Sealos App Store, review the configuration values, and click **Deploy**. Sealos renders the template variables, creates the required Kubernetes resources, and manages the public endpoint for the application.

## Deployment Preconditions

- No GPU is required.
- No external database is required.
- The cluster must be able to pull `rustfs/rustfs:1.0.0-beta.8`.
- The namespace must have enough quota for 4 Pods, at least 4Gi of data PVC capacity, and at least 2 CPU limit across the 4 RustFS Pods.
- The default HA layout intentionally uses one local data endpoint per Pod: `/data/rustfs0`. Do not change `RUSTFS_VOLUMES` to multiple local endpoints per Pod unless the target cluster provides physically independent disks for every local RustFS endpoint. RustFS rejects multiple local endpoints on the same physical device and exits with `local erasure endpoints must use distinct physical disks`.

## Access

After deployment, open `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`. The concrete hostname is generated from `defaults.app_host` and your Sealos Cloud domain.

## Configuration

The following user-facing inputs are available during deployment:

| Name | Description | Required | Default |
|------|-------------|----------|---------|
| `access_key` | S3 Access Key for authentication | `true` | generated |
| `console_enable` | Enable web console interface | `false` | `true` |
| `secret_key` | S3 Secret Key for authentication | `true` | generated |

Keep sensitive values in Sealos-managed inputs or generated defaults. Do not commit private credentials to the template repository.

## Official Links

- Official website: https://github.com/rustfs/rustfs
- Source repository: https://github.com/rustfs/rustfs
