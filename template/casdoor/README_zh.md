# Casdoor

## 应用概览

Casdoor 是一个基于 OAuth 2.0、OIDC、SAML 和 CAS 的 UI 优先的身份访问管理（IAM）/单点登录（SSO）平台。

此 Sealos 模板会将 **Casdoor** 部署为 `casdoor` 应用。部署、网络和存储配置都由仓库中的 Sealos 模板维护。

## 在 Sealos 上部署

在 Sealos 应用商店打开此模板，检查配置项后点击 **部署**。Sealos 会渲染模板变量，创建所需的 Kubernetes 资源，并为应用管理公网访问入口。

## 访问方式

部署完成后，打开 `https://${{ defaults.app_host }}.${{ SEALOS_CLOUD_DOMAIN }}`。实际域名由 `defaults.app_host` 和当前 Sealos Cloud 域名生成。

## 配置说明

部署时可以配置以下用户可见输入项：

| 名称 | 说明 | 必填 | 默认值 |
|------|------|------|--------|
| `driver_name` | 数据库驱动名称，可选 `postgres`、`mysql` 或 `sqlite`。 | `否` | `postgres` |

请将敏感信息保存在 Sealos 管理的输入项或生成默认值中，不要把私有凭据提交到模板仓库。

生产部署建议使用 PostgreSQL。SQLite 仍可用于轻量测试，数据库文件会保存在 Casdoor 数据卷中。

## OIDC 重定向 URLs

Casdoor 作为 OIDC 身份提供商使用时，每个接入应用都需要在 Casdoor 应用设置中配置自己的重定向 URL。这个值无法由 Casdoor 模板自动填充，因为它取决于外部应用的实际访问域名。

如果接入 Outline，请添加以下重定向 URL：

```text
https://<你的-outline-域名>/auth/oidc.callback
```

例如，Outline 的访问地址是 `https://outline-example.example.com` 时，重定向 URL 应填写：

```text
https://outline-example.example.com/auth/oidc.callback
```

保存 Casdoor 应用后，把其中的客户端 ID 和客户端密钥复制到接入应用中，例如 Outline 的 OIDC 部署参数。

## 官方链接

- 官方网站: https://casdoor.org/
- 源码仓库: https://github.com/casdoor/casdoor
