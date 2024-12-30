{{- define "platformex.deployment.replicas" }}
{{- if .deployment.worker | default false}}
{{- include "platformex.deployment.worker.replicas" . }}
{{- else }}
replicas: {{ .deployment.replicas }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.volumes" }}
{{- if .deployment.volumes }}
volumes:
{{- toYaml .deployment.volumes | nindent 2 }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.nodeSelector" }}
{{- if .deployment.nodeSelector }}
nodeSelector:
{{- toYaml .deployment.nodeSelector | nindent 2 }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.imagePullSecrets" }}
{{- if .deployment.imagePullSecrets }}
{{- else }}
imagePullSecrets: {{- range .root.Values.global.defaults.imagePullSecrets }}
  - {{ . }}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.envFrom" }}
{{- if .envFrom }}
envFrom:
{{- toYaml .envFrom | nindent 2 }}
{{- end }}
{{- end }}

## TODO: move to _container.tpl
{{- define "platformex.deployment.image" }}
{{- if .container.image }}
image: {{ .container.image }}
{{- else if .container.imageRef }}
{{- $ref := required "imageRef must be defined in imageRefs to be used!" (get .root.Values.imageRefs .container.imageRef) }}
image: {{ $ref.repository }}:{{ $ref.tag }}
{{- else }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.env" }}
env:
{{- range $name, $env := .container.env }}
 - name: {{ $name }}
 {{- if typeIs "string" $env }}
   value: {{ $env }}
 {{- else if hasKey $env "valueFrom" }}
   valueFrom:
    {{- toYaml $env.valueFrom | nindent 4 }}
 {{- end }}
{{- end }}
{{- if .container.envRefs }}
{{- range $envRef := .container.envRefs }}
{{- $ref := required "envRef must be defined in envRefs to be used!" (get $.root.Values.envRefs $envRef) }}
{{- range $name, $env := $ref }}
 - name: {{ $name }}
 {{- if typeIs "string" $env }}
   value: {{ $env }}
 {{- else if hasKey $env "valueFrom" }}
   valueFrom:
    {{- toYaml $env.valueFrom | nindent 4 }}
 {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.volumeMounts" }}
{{- if .volumeMounts }}
volumeMounts:
{{- range .volumeMounts }}
- {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.deployment.worker.replicas" }}
{{- if eq .instance.enableWorkers true}}
replicas: {{ .deployment.replicas }}
{{- else }}
replicas: 0
{{- end }}
{{- end }}