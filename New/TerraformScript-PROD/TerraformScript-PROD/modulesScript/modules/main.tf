provider "aws" {
  region = var.aws_region
}

# module "api_gateway" {
#   source = "./api_gateway"
#   aws_region    = var.aws_region
#   api_name      = var.api_name
#   api_description = var.api_description
#   endpoint_type = var.endpoint_type
#   stage_name    = var.stage_name
#   tags          = var.tags
#   username      = var.username
#   lambda_authorizer_name = var.lambda_authorizer_name
# }

# module "dynamodb" {
#   source = "./dynamodb"
#   aws_region    = var.aws_region
#   table_name    = var.table_name
#   table_class   = var.table_class
#   billing_mode  = var.billing_mode
#   hash_key      = var.hash_key
#   hash_key_type = var.hash_key_type
#   range_key     = var.range_key
#   range_key_type = var.range_key_type
#   server_side_encryption_enabled = var.server_side_encryption_enabled
#   kms_key_arn   = var.kms_key_arn
#   point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
#   ttl_attribute_name = var.ttl_attribute_name
#   ttl_enabled   = var.ttl_enabled
#   stream_enabled = var.stream_enabled
#   stream_view_type = var.stream_view_type
#   owner_name    = var.owner_name
#   environment   = var.environment
#   username      = var.username
# }

# module "ec2" {
#   source = "./ec2"
#   aws_region = var.aws_region
#   instance_type = var.instance_type
#   instance_vm_id = var.instance_vm_id
#   instance_name = var.instance_name
#   vpc_id = var.vpc_id
#   subnet_id = var.subnet_id
#   username = var.username
#   owner_name = var.owner_name
# }

# module "eks" {
#   source = "./eks"
#   aws_region = var.aws_region
#   vpc_id = var.vpc_id
#   private_subnet_ids = var.private_subnet_ids
#   cluster_name = var.cluster_name
#   cluster_role_arn = var.cluster_role_arn
#   project_name = var.project_name
#   resource_owner_email = var.resource_owner_email
#   environment = var.environment
#   username = var.username
#   launch_template_name_prefix = var.launch_template_name_prefix
#   iam_instance_profile_name = var.iam_instance_profile_name
#   launch_template_tag_name = var.launch_template_tag_name
#   instance_type = var.eks_instance_type
#   fargate_profile_name = var.fargate_profile_name
#   fargate_selector_namespace_default = var.fargate_selector_namespace_default
#   fargate_selector_namespace_prod = var.fargate_selector_namespace_prod
#   fargate_selector_namespace_kube_system = var.fargate_selector_namespace_kube_system

#   # NLB EKS Pods Security Group variables
#   nlb_eks_pods_sg_name             = var.nlb_eks_pods_sg_name
#   nlb_eks_pods_sg_description      = var.nlb_eks_pods_sg_description
#   nlb_eks_pods_ingress_description = var.nlb_eks_pods_ingress_description
#   nlb_eks_pods_ingress_from_port   = var.nlb_eks_pods_ingress_from_port
#   nlb_eks_pods_ingress_to_port     = var.nlb_eks_pods_ingress_to_port
#   nlb_eks_pods_ingress_protocol    = var.nlb_eks_pods_ingress_protocol
#   nlb_eks_pods_ingress_cidr_blocks = var.nlb_eks_pods_ingress_cidr_blocks
#   nlb_eks_pods_egress_from_port    = var.nlb_eks_pods_egress_from_port
#   nlb_eks_pods_egress_to_port      = var.nlb_eks_pods_egress_to_port
#   nlb_eks_pods_egress_protocol     = var.nlb_eks_pods_egress_protocol
#   nlb_eks_pods_egress_cidr_blocks  = var.nlb_eks_pods_egress_cidr_blocks
# }

########################################
# EventBridge + Scheduler + IAM
########################################
module "eventbridge" {
  source = "./eventbridge"

  rules = var.rules

  schedule_group_name = var.schedule_group_name
  scheduler_role_name = var.scheduler_role_name

  # ✅ IMPORTANT: get lambda ARNs from lambda module
  lambda_arns = ["arn:aws:lambda:ap-northeast-1:631534400818:function:cpgm-qa-lambda-email-delivery"]

  eks_policy_name = var.eks_policy_name

  tags = var.tags
}


########################################
# # Lambda Module (your existing)
# ########################################

#  module "lambda" {
#   source = "./lambda"

#   lambda_artifact   = "lambda.zip"
#   private_subnet_ids = var.private_subnet_ids
#   lambda_sg_id       = var.lambda_sg_id

#   lambdas = var.lambdas
#   tags    = var.tags
#}





# module "lambda" {
#   source = "./lambda"
#   aws_region = var.aws_region
#   function_name = var.function_name
#   lambda_handler = var.lambda_handler
#   lambda_runtime = var.lambda_runtime
#   memory_size = var.memory_size
#   timeout = var.timeout
#   lambda_zip_path = var.lambda_zip_path
#   vpc_id = var.vpc_id
#   private_subnet_ids = var.private_subnet_ids
#   environment_variables = var.environment_variables
#   tags = var.tags
#   username = var.username
# }

# module "nlb" {
#   source = "./nlb"
#   vpc_id = var.vpc_id
#   nlb_name = var.nlb_name
#   nlb_tags = var.nlb_tags
#   subnets = var.subnets
#   service_ports = var.service_ports
# }

# module "rds" {
#   source = "./rds"
#   aws_region = var.aws_region
#   aws_username = var.username
#   subnet_group_name = var.subnet_group_name
#   db_instance_identifier = var.db_instance_identifier
#   db_engine = var.db_engine
#   db_engine_version = var.db_engine_version
#   instance_class = var.instance_class
#   allocated_storage = var.allocated_storage
#   storage_type = var.storage_type
#   username = var.db_username
#   password = var.db_password
#   port = var.db_port
#   vpc_security_group_ids = var.vpc_security_group_ids
#   backup_retention_period = var.backup_retention_period
# }

# module "sns" {
#   source = "./sns"
#   aws_region = var.aws_region
#   topic_name = var.topic_name
#   subscription_protocol = var.subscription_protocol
#   subscription_endpoint = var.subscription_endpoint
#   username = var.username
# }

# module "sqs" {
#   source = "./sqs"
#   aws_region = var.aws_region
#   queue_name = var.queue_name
#   fifo_queue = var.fifo_queue
#   visibility_timeout = var.visibility_timeout
#   message_retention_period = var.message_retention_period
#   project_name = var.project_name
#   resource_owner_email = var.resource_owner_email
#   environment = var.environment
#   username = var.username
# }
