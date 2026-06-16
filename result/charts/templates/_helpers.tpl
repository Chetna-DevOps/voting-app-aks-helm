{{- define "result.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "result.fullname" -}}
result
{{- end }}

{{- define "result.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
