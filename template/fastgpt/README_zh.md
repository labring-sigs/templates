# FastGPT

统一模板部署 FastGPT `v4.17.2`，将上游 Docker Compose 服务映射为 Sealos 原生资源，并支持按需选择商业版、对象存储和 Agent Sandbox。

## 部署选项

- `use_pro`：默认 `false`，部署开源版；设为 `true` 时额外部署 FastGPT Pro/Admin `v4.17.2`，并配置主应用与 Pro 服务间凭证。
- `use_embedded_s3`：默认 `false`，使用 Sealos ObjectStorage；设为 `true` 时部署单节点 Silo S3 兼容对象存储，并使用独立的 S3 API 与 Console 域名。
- `enable_opensandbox`：默认 `false`；设为 `true` 时部署 Agent Sandbox Proxy、OpenSandbox Server 和 Volume Manager。
- `s3_storage_size`：内置 S3 对象存储持久卷大小，单位 Gi，默认 `1`。仅在开启内置 S3 存储时使用。

镜像版本固定为 FastGPT / Pro `v4.17.2`、Code Sandbox `v4.17.0`、Plugin `v1.1.4`、MCP Server `v4.15.0-beta2` 和 AIProxy `v0.7.3`。
FastGPT/Labring 组件使用 GHCR 镜像；内置 S3 存储使用 `docker.io/pgsty/silo:RELEASE.2026-10-18T00-00-00Z`，OpenSandbox 使用其上游公开镜像。

## 使用说明

1. 部署完成后等待 MongoDB、PostgreSQL、Redis 和 AIProxy 初始化完成。
2. 登录用户名是 `root`，密码为部署时填写的 `root_password`。
3. AI 模型仍需在部署后配置。AIProxy 以内网服务方式部署，由 FastGPT 调用。
4. MCP Server 地址会自动写入 FastGPT 配置。
5. OpenSandbox 使用 Kubernetes runtime 和 Sealos PVC，不使用 Docker Socket。启用前需在集群安装 Sealos Agent Sandbox 组件，包括 BatchSandbox CRD 和 `opensandbox-manager` ClusterRole。模板只部署当前应用所需的 Server、Proxy 和 Volume Manager；沙盒 PVC 使用 `openebs-vg-lvm` StorageClass。

## 存储架构

默认通过 Sealos ObjectStorage 创建独立的公共与私有 Bucket。内置 S3 模式部署 Silo，并配置内部 S3 endpoint、对外 API 与 Console 域名。FastGPT 要求的 `STORAGE_VENDOR=minio`、`BACKEND_STORAGE_MINIO_*` 和 `MINIO_*` 兼容配置保持不变。两种模式的 endpoint、凭据和 Bucket 配置分别生成。

MongoDB、向量 PostgreSQL 和 Redis 使用 Sealos Database 资源。AIProxy 与 FastGPT 共用模板内的 Sealos PostgreSQL 集群。
