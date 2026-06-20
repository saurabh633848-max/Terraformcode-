# # NLB EKS Pods Security Group variables
# variable "nlb_eks_pods_sg_name" { type = string }
# variable "nlb_eks_pods_sg_description" { type = string }
# variable "nlb_eks_pods_ingress_description" { type = string }
# variable "nlb_eks_pods_ingress_from_port" { type = number }
# variable "nlb_eks_pods_ingress_to_port" { type = number }
# variable "nlb_eks_pods_ingress_protocol" { type = string }
# variable "nlb_eks_pods_ingress_cidr_blocks" { type = list(string) }
# variable "nlb_eks_pods_egress_from_port" { type = number }
# variable "nlb_eks_pods_egress_to_port" { type = number }
# variable "nlb_eks_pods_egress_protocol" { type = string }
# variable "nlb_eks_pods_egress_cidr_blocks" { type = list(string) }

# # EKS Fargate profile and selectors
# variable "fargate_profile_name" { type = string }
# variable "fargate_selector_namespace_default" { type = string }
# variable "fargate_selector_namespace_prod" { type = string }
# variable "fargate_selector_namespace_kube_system" { type = string }

# # NLB advanced variables
# variable "nlb_tags" { type = map(string) }
# variable "subnets" { type = list(string) }
# variable "service_ports" { type = map(number) }

# # API Gateway Lambda Authorizer
# variable "lambda_authorizer_name" { type = string }
 variable "aws_region" { type = string }
# variable "username" { type = string }
# variable "tags" { type = map(string) }

# # API Gateway
# variable "api_name" { type = string }
# variable "api_description" { type = string }
# variable "endpoint_type" { type = string }
# variable "stage_name" { type = string }

# # DynamoDB
# variable "table_name" { type = string }
# variable "table_class" { type = string }
# variable "billing_mode" { type = string }
# variable "hash_key" { type = string }
# variable "hash_key_type" { type = string }
# variable "range_key" { type = string }
# variable "range_key_type" { type = string }
# variable "server_side_encryption_enabled" { type = bool }
# variable "kms_key_arn" { type = string }
# variable "point_in_time_recovery_enabled" { type = bool }
# variable "ttl_attribute_name" { type = string }
# variable "ttl_enabled" { type = bool }
# variable "stream_enabled" { type = bool }
# variable "stream_view_type" { type = string }
# variable "owner_name" { type = string }
# variable "environment" { type = string }

# # EC2
# variable "instance_type" { type = string }
# variable "instance_vm_id" { type = string }
# variable "instance_name" { type = string }
 variable "vpc_id" { type = string }
# variable "subnet_id" { type = string }

# # EKS
# variable "private_subnet_ids" { type = list(string) }
# variable "cluster_name" { type = string }
# variable "cluster_role_arn" { type = string }
# variable "project_name" { type = string }
# variable "resource_owner_email" { type = string }
# variable "launch_template_name_prefix" { type = string }
# variable "iam_instance_profile_name" { type = string }
# variable "launch_template_tag_name" { type = string }
# variable "eks_instance_type" { type = string }

# # # Lambda
# # variable "function_name" { type = string }
# # variable "lambda_handler" { type = string }
# # variable "lambda_runtime" { type = string }
# # variable "memory_size" { type = number }
# # variable "timeout" { type = number }
# # variable "lambda_zip_path" { type = string }
# # variable "environment_variables" { type = map(string) }

# # NLB
# variable "nlb_name" { type = string }

# # RDS
# variable "subnet_group_name" { type = string }
# variable "db_instance_identifier" { type = string }
# variable "db_engine" { type = string }
# variable "db_engine_version" { type = string }
# variable "instance_class" { type = string }
# variable "allocated_storage" { type = number }
# variable "storage_type" { type = string }
# variable "db_username" { type = string }
# variable "db_password" { type = string }
# variable "db_port" { type = number }
# variable "vpc_security_group_ids" { type = list(string) }
# variable "backup_retention_period" { type = number }

# # SNS
# variable "topic_name" { type = string }
# variable "subscription_protocol" { type = string }
# variable "subscription_endpoint" { type = string }

# # SQS
# variable "queue_name" { type = string }
# variable "fifo_queue" { type = bool }
# variable "visibility_timeout" { type = number }
# variable "message_retention_period" { type = number }


########################################
# EventBridge Rules
########################################
variable "rules" {
  type = map(object({
    name                = string
    schedule_expression = string
  }))
}

########################################
# Scheduler
########################################
variable "schedule_group_name" {
  type = string
}

variable "scheduler_role_name" {
  type = string
}

########################################
# Lambda
########################################
# variable "lambda_artifact" {
#   type = string
# }

# variable "private_subnet_ids" {
#   type = list(string)
# }

# variable "lambda_sg_id" {
#   type = string
# }

# variable "lambdas" {
#   type = map(object({
#     function_name         = string
#     handler               = string
#     memory_size           = number
#     timeout               = number
#     environment_variables = map(string)
#   }))
# }

########################################
# IAM
########################################
variable "eks_policy_name" {
  type = string
}

########################################
# Tags
########################################
variable "tags" {
  type = map(string)
}