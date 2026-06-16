{{- define "worker.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "worker.fullname" -}}
worker
{{- end }}

{{- define "worker.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
