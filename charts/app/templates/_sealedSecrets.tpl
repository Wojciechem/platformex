{{- define "platformex.sealedSecrets" }}
{{- if .Capabilities.APIVersions.Has "bitnami.com/v1alpha1/SealedSecret" }}
# todo: sealed secrets
{{- else }}
# todo: sealed secrets CRD not present on cluster
{{- end }}
{{- end }}