# Deploy and Host Headscale on Sealos

Headscale is an open source, self-hosted implementation of the Tailscale control server. This template deploys Headscale with Headplane, persistent storage, public Ingress access, and optional PostgreSQL on Sealos Cloud.

![Headscale Screenshot](https://raw.githubusercontent.com/labring-sigs/templates/main/template/headscale/website-screenshot.webp)

## About Hosting Headscale

Headscale provides the coordination server for a private Tailscale-compatible tailnet. It handles node registration, user management, route advertisement, DNS settings, ACL policy storage, and control-plane communication while device traffic remains peer-to-peer whenever possible.

This Sealos template runs Headscale and Headplane in one StatefulSet. Headscale serves the control plane, gRPC endpoint, and metrics endpoint, while Headplane provides a web UI for managing users, machines, routes, DNS, ACLs, and pre-auth keys.

By default, the template uses SQLite stored on persistent volume storage. If `use_postgresql` is enabled during deployment, Sealos provisions a KubeBlocks PostgreSQL `postgresql-14.8.0` cluster, creates the `headscale` database, and renders the PostgreSQL settings into Headscale's `config.yaml`.

## Deployment Notes

- Keep `use_postgresql` disabled for the default SQLite deployment.
- Enable `use_postgresql` when you want a KubeBlocks-managed PostgreSQL database.
- Headscale reads database settings from `/etc/headscale/config.yaml`, so the template renders the connection details during initialization.
- If PostgreSQL mode does not start, check the PostgreSQL cluster, the `headscale-*-pg-init` Job, and the Headscale pod events.

## License

This Sealos template follows the license terms of the upstream projects. Headscale is licensed under BSD-3-Clause, and Headplane is licensed under MIT.
