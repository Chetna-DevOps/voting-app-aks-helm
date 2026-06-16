{{- define "db.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "db.fullname" -}}
db
{{- end }}

{{- define "db.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
