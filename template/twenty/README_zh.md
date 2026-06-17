# Twenty

## 应用概览

Salesforce 的开源替代品。支持自定义视图（看板/表格）、灵活的数据管理、工作流自动化。基于 TypeScript、React、NestJS、PostgreSQL 构建。

此 Sealos 模板会将 **Twenty** 部署为 `twenty` 应用。部署、网络和存储配置都由仓库中的 Sealos 模板维护。

## 内置依赖

默认部署会创建所有必需的运行组件：

- Twenty 应用服务（`twentycrm/twenty:v1.12.0`）
- Twenty worker（`twentycrm/twenty:v1.12.0`）
- PostgreSQL 14.8.0（KubeBlocks `postgresql-14.8.0`）
- Redis 7.0.6（KubeBlocks `redis-7.0.6`）
- 应用服务使用的本地持久化文件存储
- Sealos 管理的 HTTPS Ingress

此模板不需要 GPU 资源。目标 Sealos 集群在部署前必须提供上述 KubeBlocks 集群定义和版本。如果 PostgreSQL 14.8.0 或 Redis 7.0.6 不可用，应在创建应用实例前阻断部署，避免生成部分运行但不可用的实例。

## 在 Sealos 上部署

在 Sealos 应用商店打开此模板，检查配置项后点击 **部署**。Sealos 会渲染模板变量，创建所需的 Kubernetes 资源，并为应用管理公网访问入口。

首次部署时，应用服务可能需要数分钟完成基于数据库的初始化，之后 `/healthz` 才会进入 ready。模板已经为这个冷启动窗口配置 startup probe。

## 访问方式

部署完成后，打开 `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`。实际域名由 `defaults.app_host` 和当前 Sealos Cloud 域名生成。

## 配置说明

部署时可以配置以下用户可见输入项：

此模板没有额外的用户输入项；保留默认配置即可完成部署。

请将敏感信息保存在 Sealos 管理的输入项或生成默认值中，不要把私有凭据提交到模板仓库。

## 故障排查

### 应用 Pod 启动阶段显示 `Running 0/1`

Twenty 首次连接 PostgreSQL 和 Redis 初始化时，前几分钟未 ready 是正常现象。如果超过启动窗口仍未 ready，请查看 Pod 事件和日志。

### 数据库组件创建失败

请确认集群已提供 KubeBlocks PostgreSQL `postgresql-14.8.0` 和 Redis `redis-7.0.6`。这是默认模板的必需依赖。

## 官方链接

- 官方网站: https://twenty.com
- 源码仓库: https://github.com/twentyhq/twenty
