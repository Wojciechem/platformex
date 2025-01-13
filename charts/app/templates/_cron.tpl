{{- define "platformex.cron.suspend" }}
{{- if eq .instance.enableCrons false }}
suspend: "true"
{{- end }}
{{- end }}