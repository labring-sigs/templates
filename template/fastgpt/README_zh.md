# FastGPT

统一模板部署 FastGPT `v4.17.2`，将上游 Docker Compose 服务映射为 Sealos 原生资源，并支持按需选择商业版、对象存储和 Agent Sandbox。

## 部署选项

- `enable_pro`：默认 `false`；设为 `true` 部署 FastGPT Pro/Admin 商业版。
- `install_s3`：默认 `false` 使用 Sealos ObjectStorage；设为 `true` 部署 Silo S3。
- `enable_skills`：默认 `false`；设为 `true` 部署 Agent Sandbox 组件以开启 Skills。
- `s3_storage_size`：S3 存储卷大小（Gi），默认 `1`，仅在 `install_s3` 开启时生效。

镜像版本固定为 FastGPT / Pro `v4.17.2`、Code Sandbox `v4.17.0`、Plugin `v1.1.4`、MCP Server `v4.15.0-beta2` 和 AIProxy `v0.7.3`。
FastGPT/Labring 组件使用 GHCR 镜像；内置 S3 存储使用 `docker.io/pgsty/silo:RELEASE.2026-10-18T00-00-00Z`，OpenSandbox 使用其上游公开镜像。

## 使用说明

1. 部署完成后等待 MongoDB、PostgreSQL、Redis 和 AIProxy 初始化完成。
2. 登录用户名是 `root`；密码为部署表单中默认生成的 `root_password`，也可以自行修改。
3. AI 模型仍需在部署后配置。AIProxy 以内网服务方式部署，由 FastGPT 调用。
4. MCP Server 地址会自动写入 FastGPT 配置。
5. OpenSandbox 使用 Kubernetes runtime 和 Sealos PVC，不使用 Docker Socket。启用前需在集群安装 Sealos Agent Sandbox 组件，包括 BatchSandbox CRD 和 `opensandbox-manager` ClusterRole。模板只部署当前应用所需的 Server、Proxy 和 Volume Manager；沙盒 PVC 使用 `openebs-vg-lvm` StorageClass。每个运行态 sandbox 的资源上限为 `0.1 CPU` 和 `512Mi` 内存。

## 存储架构

默认通过 Sealos ObjectStorage 创建独立的公共与私有 Bucket。内置 S3 模式部署 Silo，并配置内部 S3 endpoint、对外 API 与 Console 域名。FastGPT 要求的 `STORAGE_VENDOR=minio`、`BACKEND_STORAGE_MINIO_*` 和 `MINIO_*` 兼容配置保持不变。两种模式的 endpoint、凭据和 Bucket 配置分别生成。

MongoDB、向量 PostgreSQL 和 Redis 使用 Sealos Database 资源。AIProxy 与 FastGPT 共用模板内的 Sealos PostgreSQL 集群。
