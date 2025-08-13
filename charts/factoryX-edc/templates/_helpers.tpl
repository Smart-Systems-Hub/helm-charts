{{/*
Expand the name of the chart.
*/}}
{{- define "txdc.name" -}}
{{- default .Chart.Name .Values.nameOverride | replace "+" "_"  | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "txdc.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "txdc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "txdc.labels" -}}
helm.sh/chart: {{ include "txdc.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Control plane labels
*/}}
{{- define "txdc.controlplane.labels" -}}
helm.sh/chart: {{ include "txdc.chart" . }}
{{ include "txdc.controlplane.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: edc-controlplane
app.kubernetes.io/part-of: edc
{{- end }}

{{/*
Data plane labels
*/}}
{{- define "txdc.dataplane.labels" -}}
helm.sh/chart: {{ include "txdc.chart" . }}
{{ include "txdc.dataplane.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/component: edc-dataplane
app.kubernetes.io/part-of: edc
{{- end }}

{{/*
Control plane selector labels
*/}}
{{- define "txdc.controlplane.selectorLabels" -}}
app.kubernetes.io/name: {{ include "txdc.name" . }}-controlplane
app.kubernetes.io/instance: {{ .Release.Name }}-controlplane
{{- end }}

{{/*
Data plane selector labels
*/}}
{{- define "txdc.dataplane.selectorLabels" -}}
app.kubernetes.io/name: {{ include "txdc.name" . }}-dataplane
app.kubernetes.io/instance: {{ .Release.Name }}-dataplane
{{- end }}

{{/*
Control plane service account name
*/}}
{{- define "txdc.controlplane.serviceaccount.name" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "txdc.fullname" . ) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Data plane service account name
*/}}
{{- define "txdc.dataplane.serviceaccount.name" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "txdc.fullname" . ) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generic service account name
*/}}
{{- define "txdc.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "txdc.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Control plane URL helpers
*/}}
{{- define "txdc.controlplane.url.protocol" -}}
{{- if .Values.controlplane.url.protocol }}
{{- .Values.controlplane.url.protocol }}
{{- else }}
{{- with (index .Values.controlplane.ingresses 0) }}
{{- if .enabled }}
{{- if .tls.enabled }}
{{- printf "https://%s" .hostname -}}
{{- else }}
{{- printf "http://%s" .hostname -}}
{{- end }}
{{- else }}
{{- printf "http://%s-controlplane:%v" ( include "txdc.fullname" $ ) $.Values.controlplane.endpoints.protocol.port -}}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- define "txdc.controlplane.url.control" -}}
{{- printf "http://%s-controlplane:%v%s" ( include "txdc.fullname" $ ) $.Values.controlplane.endpoints.control.port $.Values.controlplane.endpoints.control.path -}}
{{- end }}

{{- define "txdc.controlplane.url.validation" -}}
{{- printf "%s/token" ( include "txdc.controlplane.url.control" $ ) -}}
{{- end }}

{{/*
Data plane URL helpers
*/}}
{{- define "txdc.dataplane.url.control" -}}
{{- printf "http://%s-dataplane:%v%s" ( include "txdc.fullname" $ ) $.Values.dataplane.endpoints.control.port $.Values.dataplane.endpoints.control.path -}}
{{- end }}

{{- define "txdc.dataplane.url.public" -}}
{{- if .Values.dataplane.url.public }}
{{- .Values.dataplane.url.public }}
{{- else }}
{{- with (index  .Values.dataplane.ingresses 0) }}
{{- if .enabled }}
{{- if .tls.enabled }}
{{- printf "https://%s%s" .hostname $.Values.dataplane.endpoints.public.path -}}
{{- else }}
{{- printf "http://%s%s" .hostname $.Values.dataplane.endpoints.public.path -}}
{{- end }}
{{- else }}
{{- printf "http://%s-dataplane:%v%s" (include "txdc.fullname" $ ) $.Values.dataplane.endpoints.public.port $.Values.dataplane.endpoints.public.path -}}
{{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/* =====================
      FXDC aliases
====================== */}}

{{- define "fxdc.name" -}}
{{- include "txdc.name" . -}}
{{- end }}

{{- define "fxdc.fullname" -}}
{{- include "txdc.fullname" . -}}
{{- end }}

{{- define "fxdc.chart" -}}
{{- include "txdc.chart" . -}}
{{- end }}

{{- define "fxdc.labels" -}}
{{- include "txdc.labels" . -}}
{{- end }}

{{- define "fxdc.controlplane.labels" -}}
{{- include "txdc.controlplane.labels" . -}}
{{- end }}

{{- define "fxdc.dataplane.labels" -}}
{{- include "txdc.dataplane.labels" . -}}
{{- end }}

{{- define "fxdc.controlplane.selectorLabels" -}}
{{- include "txdc.controlplane.selectorLabels" . -}}
{{- end }}

{{- define "fxdc.dataplane.selectorLabels" -}}
{{- include "txdc.dataplane.selectorLabels" . -}}
{{- end }}

{{- define "fxdc.controlplane.serviceaccount.name" -}}
{{- include "txdc.controlplane.serviceaccount.name" . -}}
{{- end }}

{{- define "fxdc.dataplane.serviceaccount.name" -}}
{{- include "txdc.dataplane.serviceaccount.name" . -}}
{{- end }}

{{- define "fxdc.serviceAccountName" -}}
{{- include "txdc.serviceAccountName" . -}}
{{- end }}

{{- define "fxdc.controlplane.url.protocol" -}}
{{- include "txdc.controlplane.url.protocol" . -}}
{{- end }}

{{- define "fxdc.controlplane.url.control" -}}
{{- include "txdc.controlplane.url.control" . -}}
{{- end }}

{{- define "fxdc.controlplane.url.validation" -}}
{{- include "txdc.controlplane.url.validation" . -}}
{{- end }}

{{- define "fxdc.dataplane.url.control" -}}
{{- include "txdc.dataplane.url.control" . -}}
{{- end }}

{{- define "fxdc.dataplane.url.public" -}}
{{- include "txdc.dataplane.url.public" . -}}
{{- end }}
