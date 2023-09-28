resource "datadog_monitor" "healthcheck" {
  name    = "Webservers localhost http healthcheck"
  type    = "service check"
  query   = "\"http.can_connect\".over(\"instance:redmine\").by(\"host\").last(6).count_by_status()"
  message = "{{#is_alert}}\nHost {{host.name}} is not available via http. Level: {{threshold}} \n{{/is_alert}} \n{{#is_alert_recovery}}\nHost {{host.name}} is available\n{{/is_alert_recovery}} @all"

  monitor_thresholds {
    critical = 5
    warning  = 2
    ok       = 1
  }

  notify_audit      = false
  notify_no_data    = true
  no_data_timeframe = 2
  renotify_interval = 0
  timeout_h         = 0
  include_tags      = true
  new_group_delay   = 60

  priority = 2
}