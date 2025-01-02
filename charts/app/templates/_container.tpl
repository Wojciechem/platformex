{{- define "platformex.containerFull" }}
name: {{ .name }}
{{- include "platformex.container.image" . }}
{{- include "platformex.container.imagePullPolicy" . }}
{{- include "platformex.container.command" . }}
{{- include "platformex.container.env" . }}
{{- include "platformex.container.envFrom" . }}
{{- include "platformex.container.volumeMounts" .container }}
{{- include "platformex.container.lifecycle" .container }}
{{- include "platformex.container.ports" .container }}
{{- include "platformex.container.probes" .container }}
{{- include "platformex.container.resources" .container }}
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
   valueFrom: {{- toYaml $env.valueFrom | nindent 4 }}
 {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.container.volumeMounts" }}
{{- if .volumeMounts }}
volumeMounts:
{{- range .volumeMounts }}
- {{- toYaml . | nindent 2}}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.container.command" }}
{{- if .container.command }}
command:
{{- range .container.command }}
    - {{. | quote}}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.container.lifecycle" }}
{{- if .lifecycle }}
lifecycle:
{{- toYaml .lifecycle | nindent 2 }}
{{- end }}
{{- end }}

{{- define "platformex.container.ports" }}
{{- if .ports }}
ports:
{{- range .ports }}
- name: {{ .name }}
  containerPort: {{ .containerPort }}
  protocol: {{ .protocol }}
{{- end }}
{{- end }}
{{- end }}

{{- define "platformex.container.probes" }}
{{- if .livenessProbe }}
livenessProbe:
    {{- toYaml .livenessProbe | nindent 2 }}
{{- end }}
{{- if .readinessProbe }}
readinessProbe:
    {{- toYaml .readinessProbe | nindent 2 }}
{{- end }}
{{- if .startupProbe }}
startupProbe:
    {{- toYaml .startupProbe | nindent 2 }}
{{- end }}
{{- end }}

{{- define "platformex.container.resources" }}
{{- if .resources }}
resources:
    {{- toYaml .resources | nindent 2 }}
{{- end }}
{{- end }}
