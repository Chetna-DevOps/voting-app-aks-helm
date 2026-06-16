{{- define "redis.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "redis.fullname" -}}
redis
{{- end }}

{{- define "redis.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
