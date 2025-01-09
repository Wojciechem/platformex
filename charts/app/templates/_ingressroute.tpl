{{- define "platformex.ingressroute" }}
{{- range .routes }}
- match: {{ .match }}
  kind: Rule
  middlewares:
    {{- range .middlewares}}
    - name: {{ .name }}
    {{- end }}
  services:
    - kind: Service
      name: {{ $.svc }}
      port: {{ $.port }}
{{/*  # TODO: support for custom service definitions */}}
{{/*  # TODO: support for TraefikService */}}
{{- end }}
{{- end }}

{{- define "platformex.ingressroute.simple" }}
{{- if .ingress.simple}}
- match: Host(`{{ .ingress.simple }}`)
  kind: Rule
  services:
    - kind: Service
      name: {{ .svc }}
      port: {{ .port }}
{{- end }}
{{- end }}
