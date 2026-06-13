# Deploy and Host Chromium on Sealos

Chromium is the open-source browser project behind Chrome and other Chromium-based browsers. This template deploys the LinuxServer.io Chromium container with a Selkies web desktop UI, persistent browser storage, and HTTPS ingress on Sealos Cloud.

## About Hosting Chromium

Chromium runs as a single browser desktop service that you access through a web-based interface. The deployment uses the `linuxserver/chromium` image, starts Chromium automatically, and exposes the Selkies desktop on port `3000` behind a Sealos-managed HTTPS domain.

The template provisions persistent storage for `/config`, so browser profile data, downloaded files, settings, and extensions can survive container restarts. It also configures HTTP basic authentication, startup/readiness/liveness checks, and a constrained virtual display size to keep resource usage predictable.

This template is intended for personal cloud browsing, testing, demos, and lightweight remote browser workflows. Because browser desktops can expose powerful in-container capabilities, keep the generated password private and avoid sharing the public URL with untrusted users.

## Common Use Cases

- **Cloud Browser Workspace**: Run Chromium from a browser when your local device is locked down or underpowered.
- **Web App Testing**: Check websites from a clean remote browser profile with persistent settings.
- **Remote Troubleshooting**: Open pages, reproduce issues, and inspect behavior from a server-side browser session.
- **Demo Environments**: Provide a controlled browser session for demos, training, or temporary access.
- **Persistent Browser Profile**: Keep cookies, extensions, bookmarks, and session data across restarts through persistent storage.

## Dependencies for Chromium Hosting

The Sealos template includes the required runtime components for hosting Chromium:

- `lscr.io/linuxserver/chromium:cca5154d-ls37`
- A StatefulSet running the Chromium/Selkies container
- Persistent storage mounted at `/config`
- A Service and HTTPS Ingress for browser access
- A ConfigMap-based launcher that starts Chromium with stable runtime flags

### Deployment Dependencies

- [Chromium](https://www.chromium.org/chromium-projects/) - Chromium project website
- [LinuxServer.io Chromium Documentation](https://docs.linuxserver.io/images/docker-chromium/) - Container configuration and runtime options
- [linuxserver/docker-chromium GitHub Repository](https://github.com/linuxserver/docker-chromium) - Upstream image source repository
- [Sealos App Store](https://sealos.io/products/app-store/chromium) - Chromium template page
- [Sealos Discord](https://discord.gg/wdUn538zVP) - Community support

### Implementation Details

**Architecture Components:**

This template deploys the following resources:

- **Chromium StatefulSet**: Runs the LinuxServer.io Chromium container with a web-accessible Selkies desktop.
- **Launcher ConfigMap**: Installs an autostart script that launches Chromium with the configured startup URL or CLI flags.
- **Persistent Storage**: Mounts `/config` through a 1 GiB PVC for browser profile data and user files.
- **Service**: Exposes the container's HTTP desktop UI on port `3000` inside the cluster.
- **Ingress**: Provides a public HTTPS URL through Sealos-managed ingress and certificates.
- **App Link**: Adds the deployed Chromium URL to the Sealos application view.

**Configuration:**

The template sets `CHROMIUM_CLI` from the deployment form, so you can provide a startup URL or Chromium CLI flags. It enables HTTP basic authentication through `CUSTOM_USER` and a generated password, stores the browser profile under `/config`, and disables public sharing/collaboration toggles in Selkies by default.

For stable cloud execution, the template uses `PIXELFLUX_WAYLAND=false`, `MAX_RES=4096x2160`, `SELKIES_ENCODER=jpeg,x264enc`, and Chromium launch flags such as `--disable-dev-shm-usage`. The container uses `200m` CPU and `1024Mi` memory limits, with requests derived from the Sealos resource ladder.

**License Information:**

The upstream `linuxserver/docker-chromium` repository is published under the GPL-3.0 license. Chromium is an open-source browser project; review the upstream project and image licenses before using the browser in production or shared environments.

## Why Deploy Chromium on Sealos?

Sealos is an AI-assisted Cloud Operating System built on Kubernetes that unifies application deployment, operations, storage, networking, and management. By deploying Chromium on Sealos, you get:

- **One-Click Deployment**: Launch a remote Chromium desktop without writing Kubernetes YAML or operating a server manually.
- **Persistent Storage Included**: Keep browser data and settings across restarts with built-in persistent volumes.
- **Instant Public Access**: Receive an HTTPS URL with certificate management handled by Sealos.
- **Easy Customization**: Update startup URLs, credentials, resources, and storage from Canvas, AI dialog, or resource cards.
- **Kubernetes Foundation**: Run the browser on a managed Kubernetes platform with standard workload, service, ingress, and storage primitives.
- **Resource Efficiency**: Use pay-as-you-go resources and adjust CPU, memory, and storage when your workload changes.

Deploy Chromium on Sealos when you need a remote browser quickly and want to spend time browsing or testing instead of maintaining infrastructure.

## Deployment Guide

1. Open the [Chromium template](https://sealos.io/products/app-store/chromium) and click **Deploy Now**.
2. Configure the parameters in the popup dialog:
   - **Chromium startup URL or CLI flags**: Set the initial page or extra Chromium flags through `CHROMIUM_CLI`.
   - **Custom user**: Set the HTTP basic auth username. The default is `abc`.
3. Wait for deployment to complete. This typically takes 2-3 minutes. After deployment, you will be redirected to the Canvas. For later changes, describe your requirements in the AI dialog to let AI apply updates, or click the relevant resource cards to modify settings.
4. Access your application via the provided URL:
   - **Chromium Web Desktop**: Log in with the configured username and generated password, then use Chromium through the web interface.

## Configuration

After deployment, you can configure Chromium through:

- **AI Dialog**: Describe changes such as updating the startup URL, increasing resources, or adjusting environment variables.
- **Resource Cards**: Open the StatefulSet, Ingress, or storage resource card to modify runtime settings.
- **Environment Variables**: Tune `CHROMIUM_CLI`, `CUSTOM_USER`, `PASSWORD`, `MAX_RES`, and Selkies settings.
- **Persistent Profile**: Browser state is stored under `/config`; increase storage if you plan to keep large downloads or many extensions.

## Scaling

Chromium is deployed as a single-user StatefulSet with one replica. For this template, vertical scaling is usually the right approach:

1. Open the Canvas for your deployment.
2. Click the Chromium StatefulSet resource card.
3. Adjust CPU, memory, or storage according to your workload.
4. Apply the changes in the dialog and wait for the workload to restart.

For heavy pages, video playback, many tabs, or extension-heavy profiles, increase memory before increasing replica count.

## Troubleshooting

### Common Issues

**Chromium opens but pages fail or crash**
- Cause: Browser workloads can be memory-sensitive, especially with complex pages or many tabs.
- Solution: Increase the StatefulSet memory limit, close unused tabs, or reduce the virtual display size.

**The web desktop is black or Chromium is not visible**
- Cause: Desktop stack compatibility or startup timing can prevent the visible browser window from appearing.
- Solution: Confirm the workload is ready, keep `PIXELFLUX_WAYLAND=false`, and keep the launcher ConfigMap mounted correctly.

**Storage fills up**
- Cause: Downloads, browser cache, profile data, or crash reports can consume the `/config` PVC.
- Solution: Remove unnecessary files from the browser profile or increase the PVC size from the storage resource card.

**The UI feels slow**
- Cause: Remote browser rendering depends on CPU, memory, page complexity, network latency, and display resolution.
- Solution: Increase CPU/memory, close heavy tabs, or lower `MAX_RES` if you do not need 4K output.

### Getting Help

- [LinuxServer.io Chromium Documentation](https://docs.linuxserver.io/images/docker-chromium/)
- [linuxserver/docker-chromium Issues](https://github.com/linuxserver/docker-chromium/issues)
- [Sealos Discord](https://discord.gg/wdUn538zVP)

## Additional Resources

- [Chromium](https://www.chromium.org/chromium-projects/)
- [LinuxServer.io Documentation](https://docs.linuxserver.io/)
- [Sealos](https://sealos.io/)

## License

This Sealos template is provided as part of the Sealos templates repository. The upstream `linuxserver/docker-chromium` project is licensed under GPL-3.0, and Chromium is governed by its upstream open-source licenses.
