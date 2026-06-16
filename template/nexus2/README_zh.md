# Nexus Repository OSS 2

## 应用概览

Nexus Repository 是一个软件制品仓库管理工具，可用于集中存储和管理 Maven、npm、Docker 等开发过程中的构建产物与依赖包。此 Sealos 模板部署的是 Nexus Repository OSS 2，并提供持久化存储和公网访问入口。

## 在 Sealos 上部署

在 Sealos 应用商店打开此模板，按需调整应用名称、访问域名和存储容量，然后点击 **部署**。Sealos 会渲染模板变量，创建 StatefulSet、Service、Ingress 和数据卷等资源。

## 访问方式

部署完成后，打开应用详情页中的公网地址，或访问 `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`。首次进入后，请按照 Nexus 页面提示完成初始化和后续仓库配置。

## 配置说明

- `app_name`：应用名称，用于生成 Kubernetes 资源名称。
- `app_host`：公网访问域名前缀。
- `nexus_storage`：Nexus 数据目录的持久化存储容量，单位为 Gi。

## 数据持久化

模板会为 `/sonatype-work` 创建持久化存储，用于保存 Nexus 配置、仓库数据和上传的制品。生产环境中请根据制品规模预留足够容量。
