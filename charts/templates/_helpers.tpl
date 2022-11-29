{{/*
 Expand the name of the chart
*/}}
{{- define "common.fullname" -}}
{{- printf "%s-%s" .Values.project .Values.name | lower }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
{{- if .Chart.Version }}
app.kubernetes.io/release-version: {{ .Chart.Version }}
{{- end }}
app.kubernetes.io/hostname: {{ .Values.ingress.host.name }}
app.kubernetes.io/component: {{ .Values.env }}
app.kubernetes.io/part-of: {{ .Values.project }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/created-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Build Project Namespace
*/}}
{{- define "common.namespace" -}}
{{ printf "%s-%s-%s" .Values.project .Values.name .Values.env | replace "+" "_" | trunc 63 | trimSuffix "-" | lower }}
{{- end }}

{{/*
Annotations for ingresses
*/}}
{{- define "common.ingress.annotations" -}}
{{- if .Values.local -}}
{{- range $key, $value := .Values.localIngress.annotations -}}
{{ $key }} : {{ $value | quote }}
{{- end }}
nginx.ingress.kubernetes.io/fastcgi-params-configmap: {{ include "common.fullname" . }}-ingress-configmap
{{- else }}
{{- range $key, $value := .Values.awsIngress.annotations -}}
{{ $key }}: {{ $value | quote }}
{{- end }}
{{- end }}

{{- end }}
