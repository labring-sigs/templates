# FastGPT

This unified template deploys FastGPT `v4.17.2` as Sealos-native resources and lets you select the commercial service, object-storage backend, and Agent Sandbox components independently.

## Options

- `enable_pro`: defaults to `false`; set to `true` to deploy FastGPT Pro/Admin.
- `install_s3`: defaults to `false` and uses Sealos ObjectStorage; set to `true` to deploy Silo S3 storage.
- `enable_skills`: defaults to `false`; set to `true` to deploy the Agent Sandbox components required for Skills.
- `s3_storage_size`: S3 persistent volume size in GiB; defaults to `1` and applies only when `install_s3` is enabled.

The image versions are pinned to FastGPT / Pro `v4.17.2`, Code Sandbox `v4.17.0`, Plugin `v1.1.4`, MCP Server `v4.15.0-beta2`, and AIProxy `v0.7.3`.
FastGPT/Labring component images use GHCR. Embedded S3 storage uses `docker.io/pgsty/silo:RELEASE.2026-10-18T00-00-00Z`; OpenSandbox uses its upstream public images.

## Notes

1. Allow time for MongoDB, PostgreSQL, Redis, and AIProxy to initialize.
2. Sign in as `root` with the generated `root_password` shown in the deployment form, or the custom value you entered.
3. Configure AI models after deployment. AIProxy is deployed as an internal service and called by FastGPT.
4. The MCP Server endpoint is configured automatically.
5. OpenSandbox uses the Kubernetes runtime and Sealos PVCs; it does not mount the Docker socket. Before enabling it, install the Sealos Agent Sandbox component, including its BatchSandbox CRDs and the `opensandbox-manager` ClusterRole. This template deploys only the per-app server, proxy, and volume manager. Sandbox PVCs use the `openebs-vg-lvm` StorageClass. Each runtime sandbox is capped at `0.1` CPU and `512Mi` memory.
6. FastGPT's vector database and AIProxy share the template's Sealos PostgreSQL cluster.

## Storage

By default, the template creates separate public and private Sealos ObjectStorage buckets. Embedded S3 mode instead deploys Silo and configures its internal S3 endpoint plus externally reachable API and Console domains. FastGPT's required `STORAGE_VENDOR=minio`, `BACKEND_STORAGE_MINIO_*`, and `MINIO_*` compatibility settings remain unchanged. Credentials and endpoint settings are generated separately for each mode.
