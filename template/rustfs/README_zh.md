# RustFS

## 应用概览

RustFS 是一个使用 Rust 构建的高性能 S3 兼容对象存储系统，提供分布式存储能力，支持多卷存储。

此 Sealos 模板会将 **RustFS** 部署为 4 节点高可用应用。每个 RustFS Pod 持有一个数据 PVC，并共同组成同一个分布式卷集合。

## 在 Sealos 上部署

在 Sealos 应用商店打开此模板，检查配置项后点击 **部署**。Sealos 会渲染模板变量，创建所需的 Kubernetes 资源，并为应用管理公网访问入口。

## 部署前置条件

- 不需要 GPU。
- 不需要外部数据库。
- 集群必须能够拉取 `rustfs/rustfs:1.0.0-beta.8` 镜像。
- 命名空间必须有足够配额创建 4 个 Pod，至少剩余 4Gi 数据 PVC 容量，并为 4 个 RustFS Pod 预留总计至少 2 核 CPU limit。
- 默认 HA 布局刻意让每个 Pod 只使用一个本地数据端点：`/data/rustfs0`。不要把 `RUSTFS_VOLUMES` 改成每个 Pod 多个本地端点，除非目标集群能为每个 RustFS 本地端点提供相互独立的物理磁盘。RustFS 会拒绝同一物理设备上的多个本地端点，并以 `local erasure endpoints must use distinct physical disks` 退出。

## 访问方式

部署完成后，打开 `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`。实际域名由 `defaults.app_host` 和当前 Sealos Cloud 域名生成。

## 配置说明

部署时可以配置以下用户可见输入项：

| 名称 | 说明 | 必填 | 默认值 |
|------|------|------|--------|
| `access_key` | S3 Access Key。 | `是` | 自动生成 |
| `console_enable` | 是否启用 Web Console。 | `否` | `true` |
| `secret_key` | S3 Secret Key。 | `是` | 自动生成 |

请将敏感信息保存在 Sealos 管理的输入项或生成默认值中，不要把私有凭据提交到模板仓库。

## 官方链接

- 官方网站: https://github.com/rustfs/rustfs
- 源码仓库: https://github.com/rustfs/rustfs
