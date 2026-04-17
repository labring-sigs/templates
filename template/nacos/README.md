
<img src="./Nacos_Logo.png" width="50%" syt height="50%" />

# Nacos: Dynamic  *Na*ming and *Co*nfiguration *S*ervice

-------

## What does it do

Nacos (official site: [nacos.io](https://nacos.io)) is an easy-to-use platform designed for dynamic service discovery and configuration and service management. It helps you to build cloud native applications and microservices platform easily.

Service is a first-class citizen in Nacos. Nacos supports almost all type of services，for example，[Dubbo/gRPC service](https://nacos.io/docs/latest/ecology/use-nacos-with-dubbo/), [Spring Cloud RESTFul service](https://nacos.io/docs/latest/ecology/use-nacos-with-spring-cloud/) or [Kubernetes service](https://nacos.io/docs/latest/quickstart/quick-start-kubernetes/).

Nacos provides four major functions.

* **Service Discovery and Service Health Check**

  Nacos makes it simple for services to register themselves and to discover other services via a DNS or HTTP interface. Nacos also provides real-time health checks of services to prevent sending requests to unhealthy hosts or service instances.

* **Dynamic Configuration Management**

  Dynamic Configuration Service allows you to manage configurations of all services in a centralized and dynamic manner across all environments. Nacos eliminates the need to redeploy applications and services when configurations are updated, which makes configuration changes more efficient and agile.

* **Dynamic DNS Service**

  Nacos supports weighted routing, making it easier for you to implement mid-tier load balancing, flexible routing policies, flow control, and simple DNS resolution services in the production environment within your data center. It helps you to implement DNS-based service discovery easily and prevent applications from coupling to vendor-specific service discovery APIs.

* **Service and MetaData Management**

  Nacos provides an easy-to-use service dashboard to help you manage your services metadata, configuration, kubernetes DNS, service health and metrics statistics.


## Quick Start
It is super easy to get started with your first project.

### Deploying Nacos on cloud

You can deploy Nacos on cloud, which is the easiest and most convenient way to start Nacos.

Use the following [Nacos deployment guide](https://cn.aliyun.com/product/aliware/mse?spm=nacos-website.topbar.0.0.0) to see more information and deploy a stable and out-of-the-box Nacos server.


### Start by the provided startup package

#### Step 1: Download the binary package

You can download the package from the [latest stable release](https://github.com/alibaba/nacos/releases).

Take release `nacos-server-1.0.0.zip` for example:
```sh
unzip nacos-server-1.0.0.zip
cd nacos/bin 
``` 

#### Step 2: Start Server

On the **Linux/Unix/Mac** platform, run the following command to start server with standalone mode:
```sh
sh startup.sh -m standalone
```

On the **Windows** platform, run the following command to start server with standalone mode.  Alternatively, you can also double-click the `startup.cmd` to run NacosServer.
```
startup.cmd -m standalone
```

For more details, see [quick-start.](https://nacos.io/docs/latest/quickstart/quick-start/)


#### Step 3: Access Nacos Console

After the server is started, you can access the Nacos console at `http://localhost:8848/nacos` with the default username and password `nacos/nacos`.

Username: `nacos` and password: `nacos` to login the console, you can see the dashboard of Nacos.