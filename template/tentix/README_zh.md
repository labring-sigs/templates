# tentix

## 应用概览

tentix 是一个可在 Sealos 上一键部署的应用，模板会创建所需资源并提供应用访问入口。

此 Sealos 模板会将 **tentix** 部署为 `tentix` 应用。部署、网络和存储配置都由仓库中的 Sealos 模板维护。

## 内置依赖

默认部署会创建 PostgreSQL `postgresql-14.8.0`、Sealos 对象存储、Tentix 迁移容器、应用 Deployment、Service、Ingress 和 App 入口。Tentix 需要 PostgreSQL `vector` 扩展，迁移前置检查会在运行迁移前校验目标数据库是否提供该扩展。

运行时镜像应已在集群镜像仓库中提供：`sealos.hub:5000/limbo2342/tentix:dev-2025-10-23-x.3` 和 `sealos.hub:5000/limbo2342/tentix:migrate.10.22.x1`。模板会在数据库迁移开始前检查应用镜像，因此镜像前置条件缺失时会尽早阻断，而不是留下部分初始化的实例。

如果目标集群的 PostgreSQL 只提供 pgvector `0.5.0`，较新的 `halfvec` 类型不可用。此时迁移前置检查会在日志中给出明确提示，并仅跳过可选的 halfvec IVFFlat 加速索引，确保默认应用仍可进入 ready 状态。若集群提供新版 pgvector 且包含 `halfvec`，模板会保留该加速索引。

此模板不需要 GPU 资源。如果目标集群不能提供可用的 PostgreSQL `vector` 扩展、Sealos 对象存储凭据，或已镜像的 Tentix 运行时镜像，应在创建应用实例前阻断部署。

## 在 Sealos 上部署

在 Sealos 应用商店打开此模板，检查配置项后点击 **部署**。Sealos 会渲染模板变量，创建所需的 Kubernetes 资源，并为应用管理公网访问入口。

## 访问方式

部署完成后，打开 `https://${{ defaults.domain }}.${{ SEALOS_CLOUD_DOMAIN }}`。实际域名由 `defaults.domain` 和当前 Sealos Cloud 域名生成。

## 配置说明

部署时可以配置以下用户可见输入项：

| 名称 | 说明 | 必填 | 默认值 |
|------|------|------|--------|
| `OPENAI_API_KEY` | `OPENAI_API_KEY` 部署参数。 | `是` | `<已隐藏>` |
| `OPENAI_BASE_URL` | `OPENAI_BASE_URL` 部署参数。 | `是` | `https://api.openai.com/v1` |

请将敏感信息保存在 Sealos 管理的输入项或生成默认值中，不要把私有凭据提交到模板仓库。

## 官方链接

- 官方网站: https://github.com/labring/tentix
- 源码仓库: https://github.com/labring/tentix
