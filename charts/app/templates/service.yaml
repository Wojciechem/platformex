apiVersion: v1
kind: List
items:
  {{- range $iname, $instance := .Values.instances }}
  {{- range $dname, $deployment := $instance.deployments }}
  {{- $deploymentContext := dict "iname" $iname "instance" $instance "name" $dname "deployment" $deployment "root" $ }}
  {{- if $deployment.service }}
  - apiVersion: v1
    kind: Service
    metadata:
      {{- if $deployment.service.nameOverride }}
      name: {{ $deployment.service.nameOverride }}
      {{- else }}
      name: {{ $iname }}-{{ $dname }}
      {{- end }}
      labels:
        {{- include "platformex.kubernetesAppLabels" $deploymentContext | indent 10 }}
        {{- include "platformex.globalLabels" $ | indent 10 }}
    spec:
      type: {{ $deployment.service.type }}
      ports:
        - port: {{ $deployment.service.port }}
          targetPort: {{ $deployment.service.targetPort }}
          protocol: {{ $deployment.service.protocol | default "TCP" }}
          name: {{ $deployment.service.portName | default "http" }}
      selector:
        {{- include "platformex.kubernetesAppLabels" $deploymentContext | indent 10 }}
  {{- end }}
  {{- end }}
  {{- end }}
