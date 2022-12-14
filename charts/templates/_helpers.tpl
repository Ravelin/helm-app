{{/*
 Expand the name of the chart
*/}}
{{- define "common.fullname" -}}
{{ printf "%s-%s" .Values.project .Values.name | lower }}
{{- end }}

{{/*
Build Project Namespace
*/}}
{{- define "common.namespace" -}}
{{ printf "%s-%s-%s" .Values.project .Values.name .Values.environment | replace "+" "_" | trunc 63 | trimSuffix "-" | lower }}
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
helm.sh/chart: {{ include "common.chart" . }} # Required
{{ include "common.selectorLabels" . }}
{{- if .Chart.Version }}
app.kubernetes.io/release-version: {{ .Chart.Version }}
{{- end }}
app.kubernetes.io/name: {{ include "common.fullname" . }} # Required
app.kubernetes.io/instance: {{ .Release.Name }} # Required
app.kubernetes.io/hostname: {{ .Values.ingress.name | lower }}
app.kubernetes.io/component: {{ .Values.environment }}
app.kubernetes.io/part-of: {{ .Values.project }}
app.kubernetes.io/managed-by: {{ .Release.Service }} # Required
app.kubernetes.io/created-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.fullname" . }} # Required
app.kubernetes.io/instance: {{ .Release.Name }}  # Required
{{- end }}