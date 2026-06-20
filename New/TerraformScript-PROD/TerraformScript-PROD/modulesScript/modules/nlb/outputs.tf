output "nlb_arn" {
  description = "The ARN of the Network Load Balancer."
  value       = aws_lb.cpgm_nlb.arn
}

# Output all service target group ARNs
output "service_target_group_arns" {
  description = "Map of service names to their target group ARNs."
  value = { for k, tg in aws_lb_target_group.service : k => tg.arn }
}
