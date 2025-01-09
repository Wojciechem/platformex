Platformex App chart
---

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
    version: 0.3.1
    repository: https://wojciechem.github.io/platformex
```
For values please see [values-example.yaml](charts/app/values-example.yaml)

## TODO:
- [ ] 1st working version
- [x] values-example.yaml file with all possible options used
- [ ] simple stupid test
- [x] json schema based on values-example.yaml
  - [ ] deployment.containers required
- use kubernetes json schema where possible:
```text
https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.31.3/probe.json

```
