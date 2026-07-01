# Vege Basket

## 应用概览

Vege Basket 是一个面向个人项目管理的工作台，用来集中整理项目、日记、草稿、待办、风险和 AI 总结。

此 Sealos 模板会将 **Vege Basket** 部署为 `vege-basket` 应用。模板会创建应用工作负载、PostgreSQL 数据库、Service 和公网 HTTPS 访问入口，部署、网络和数据库配置都由仓库中的 Sealos 模板维护。

## 在 Sealos 上部署

在 Sealos 应用商店打开此模板，检查配置项后点击 **部署**。Sealos 会渲染模板变量，创建所需的 Kubernetes 资源，并为应用管理公网访问入口。

## 访问方式

部署完成后，打开 `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`。实际域名由 `defaults.app_host` 和当前 Sealos Cloud 域名生成。

## 配置说明

部署时会使用以下生成默认值：

- `app_host`：应用公网地址使用的域名前缀。
- `app_name`：本次部署的 Kubernetes 资源名前缀。
- `encryption_key`：模板生成的 32 字节 base64 密钥，供 Vege Basket 执行应用层 AES-256-GCM 加密。

模板会同时创建 PostgreSQL 数据库保存应用数据。已有部署需要保持生成的加密密钥稳定；如果密钥丢失或被修改，已加密的项目数据将无法恢复。

## 官方链接

- 源码仓库: https://github.com/felixqiu014-wq/vege-basket
