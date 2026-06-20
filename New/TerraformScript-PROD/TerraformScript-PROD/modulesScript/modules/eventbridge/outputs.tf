########################################
# EventBridge Rule Outputs
########################################
output "eventbridge_rule_names" {
  description = "Names of EventBridge rules"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.name }
}

output "eventbridge_rule_arns" {
  description = "ARNs of EventBridge rules"
  value       = { for k, v in aws_cloudwatch_event_rule.this : k => v.arn }
}

########################################
# Scheduler Group Output
########################################
output "scheduler_group_name" {
  description = "Scheduler group name"
  value       = aws_scheduler_schedule_group.this.name
}

output "scheduler_group_arn" {
  description = "Scheduler group ARN"
  value       = aws_scheduler_schedule_group.this.arn
}

########################################
# Scheduler Role Outputs
########################################
output "scheduler_role_arn" {
  description = "IAM role ARN used by EventBridge Scheduler"
  value       = aws_iam_role.scheduler_role.arn
}

output "scheduler_role_name" {
  description = "IAM role name used by EventBridge Scheduler"
  value       = aws_iam_role.scheduler_role.name
}

########################################
# EKS Policy Output
########################################
output "eks_scheduler_policy_arn" {
  description = "IAM Policy ARN for EKS scheduler access"
  value       = aws_iam_policy.eks_scheduler_policy.arn
}
 