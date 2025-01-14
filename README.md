Platformex App chart
---
Flexible helm chart to deploy your apps to kubernetes cluster.  
Simplifies complex deployments with abstractions and reasonable defaults.

>We did it, so you won't have to.

## Disclaimer:
Please do not consider this chart "stable" or production-ready yet. We're getting there ;)

## Installation:
Use this chart as a dependency inside your app's own chart:

```yaml
apiVersion: v2
name: testbench
description: Helm chart for testbench app, based on "platformex" app chart

type: application
version: 0.1.0
appVersion: 1.0.0

dependencies:
  - name: app
    version: 0.5.11
    repository: oci://ghcr.io/wojciechem/platformex
```
For values please see [values-example.yaml](charts/app/values-example.yaml)

## TODO:
- Chart
  - [ ] Minimal stable v1.0.0
  - [ ] Tests
- [Ingress routes](charts/app/templates/_ingressroute.tpl)
  - [ ] custom service definitions for traefik ingressroutes (see https://doc.traefik.io/traefik/routing/providers/kubernetes-crd/#kind-ingressroute)
  - [ ] TraefikService support in ingressroutes
- Json schema
  - [ ] deployment.containers required
  - [ ] use kubernetes json schema where possible, [example](https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.31.3/probe.json)
