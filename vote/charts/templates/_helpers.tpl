{{- define "vote.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "vote.fullname" -}}
vote
{{- end }}

{{- define "vote.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
