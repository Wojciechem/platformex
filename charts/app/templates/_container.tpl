{{- define "platformex.containerFull" }}
name: {{ .name }}
{{- include "platformex.container.volumeMounts" .container }}
{{- include "platformex.container.envFrom" . }}
{{- include "platformex.container.env" . }}
{{- include "platformex.container.image" . }}
{{- include "platformex.container.imagePullPolicy" . }}
{{- /*              {{- include "platformex.deployment.command" $initContainer | indent 14 }}*/}}
{{- /*              {{- include "platformex.deployment.lifecycle" $initContainer | indent 14 }}*/}}
{{- /*              {{- include "platformex.deployment.ports" $initContainer | indent 14 }}*/}}
{{- /*              {{- include "platformex.deployment.liveness" $initContainer | indent 14 }}*/}}
{{- /*              {{- include "platformex.deployment.readiness" $initContainer | indent 14 }}*/}}
{{- /*              {{- include "platformex.deployment.startup" $initContainer | indent 14 }}*/}}
{{- /*              {{- include "platformex.deployment.resources" $initContainer | indent 14 }}*/}}
{{- end }}

{{- define "platformex.container.image" }}
{{- if .container.image }}
image: {{ .container.image }}
{{- else if .container.imageRef }}
{{- $ref := required "imageRef must be defined in imageRefs to be used!" (get .root.Values.imageRefs .container.imageRef) }}
image: {{ $ref.repository }}:{{ $ref.tag }}
{{- else }}
{{- end }}
{{- end }}

{{- define "platformex.container.envFrom" }}
{{- if .envFrom }}
envFrom:
{{- toYaml .envFrom | nindent 2 }}
{{- end }}
{{- end }}

{{- define "platformex.container.imagePullPolicy" }}
imagePullPolicy: {{ .container.imagePullPolicy | default "IfNotPresent" }}
{{- end }}


{{- define "platformex.container.env" }}
env:
{{- range $name, $env := .container.env }}
 - name: {{ $name }}
 {{- if typeIs "string" $env }}
   value: {{ $env }}
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

{{- define "platformex.container.volumeMounts" }}
{{- if .volumeMounts }}
volumeMounts:
{{- range .volumeMounts }}
- {{- toYaml . | nindent 2 }}
{{- end }}
{{- end }}
{{- end }}