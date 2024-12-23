{{- define "platformex.globalLabels" }}
{{- range $key, $value := $.Values.global.labels }}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{- define "platformex.kubernetesAppLabels" }}
app.kubernetes.io/name: {{ .name }}
app.kubernetes.io/instance: {{ .iname | quote }}
{{- end }}


