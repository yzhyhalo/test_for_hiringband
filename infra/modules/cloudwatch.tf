locals {
  prefix = "${{var.project_name}}-${{var.environment}}-${{var.app_name}}"

}




module "log_metric_filter" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-metric-filter"
  version = "~> 3.0"

  log_group_name = "${{local.prefix}}-log-group"

  name    = "error-metric"
  pattern = "ERROR"

  metric_transformation_namespace = "Application"
  metric_transformation_name      = "ErrorCount"
}

module "log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "${{local.prefix}}-log-group"
  retention_in_days = 120
}

module "metric_alarm" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 3.0"

  alarm_name          = $"{{var.app_name}}-logs-errors"
  alarm_description   = "errors in my-application-logs"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 10
  period              = 60
  unit                = "Count"

  namespace   = "MyApplication"
  metric_name = "ErrorCount"
  statistic   = "Maximum"

  alarm_actions = ["${{module.sns_topic}}"]
}
module "sns_topic" {
  source  = "terraform-aws-modules/sns/aws"

  name  = "${{local.prefix}}-alert"

  tags = {
    Environment = ${{var.environment}}
    Terraform   = "true"
  }
}

