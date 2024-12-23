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