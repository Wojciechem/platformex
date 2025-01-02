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

{{- define "platformex.deployment.worker.replicas" }}
{{- if eq .instance.enableWorkers true}}
replicas: {{ .deployment.replicas }}
{{- else }}
replicas: 0
{{- end }}
{{- end }}
