# output "api_gateway" {
#   value = module.api_gateway
# }
# output "dynamodb" {
#   value = module.dynamodb
# }
# output "ec2" {
#   value = module.ec2
# }
# output "eks" {
#   value = module.eks
# }
# output "lambda" {
#   value = module.lambda
# }
# output "nlb" {
#   value = module.nlb
# }
# output "rds" {
#   value = module.rds
# }
# output "sns" {
#   value = module.sns
# }
# output "sqs" {
#   value = module.sqs
# }


################################################################################
########################################
# output "lambda_arns" {
#   value = module.lambda.lambda_arns
# }

# output "lambda_names" {
#   value = module.lambda.lambda_names
# }

output "lambda_arns" {
  value = module.eventbridge.lambda_arns
}
 
########################################
# EventBridge Outputs
########################################
output "eventbridge_rule_names" {
  value = module.eventbridge.eventbridge_rule_names
}

output "eventbridge_rule_arns" {
  value = module.eventbridge.eventbridge_rule_arns
}

########################################
# Scheduler Outputs
########################################
output "scheduler_group_name" {
  value = module.eventbridge.scheduler_group_name
}

output "scheduler_group_arn" {
  value = module.eventbridge.scheduler_group_arn
}

########################################
# IAM Outputs
########################################
output "scheduler_role_arn" {
  value = module.eventbridge.scheduler_role_arn
}

output "scheduler_role_name" {
  value = module.eventbridge.scheduler_role_name
}

output "eks_scheduler_policy_arn" {
  value = module.eventbridge.eks_scheduler_policy_arn
}