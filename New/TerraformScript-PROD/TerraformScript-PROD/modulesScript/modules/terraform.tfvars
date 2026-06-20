
#Common Variable
aws_region = "ap-northeast-1"
#username = "terraform-user"
tags = {
  Environment = "PROD"
  Project     = "CampaignManagement"
  ManagedBy   = "Terraform"
}

vpc_id = "vpc-0348bb0aba03fe4cc"

# EKS NLB Pods Security Group variables
# nlb_eks_pods_sg_name = "cpgm-prod-sg-nlb-eks-pods"
# nlb_eks_pods_sg_description = "Allow NLB traffic to EKS pods"
# nlb_eks_pods_ingress_description = "Allow TCP 8081-8090 from NLB"
# nlb_eks_pods_ingress_from_port = 8081
# nlb_eks_pods_ingress_to_port = 8090
# nlb_eks_pods_ingress_protocol = "tcp"
# nlb_eks_pods_ingress_cidr_blocks = ["0.0.0.0/0"]
# nlb_eks_pods_egress_from_port = 0
# nlb_eks_pods_egress_to_port = 0
# nlb_eks_pods_egress_protocol = "-1"
# nlb_eks_pods_egress_cidr_blocks = ["0.0.0.0/0"]



# # API Gateway
# api_name = "cpgm-prod-apigw-public"
# api_description = "Campaign Management PROD API Gateway"
# endpoint_type = "REGIONAL"
# stage_name = "prod"
# lambda_authorizer_name = "cpgm-prod-lambda-authorizer"

# # DynamoDB
# table_name = "cpgm-prod-dynamo-session"
# table_class = "STANDARD"
# billing_mode = "PAY_PER_REQUEST"
# hash_key = "cognitoSub"
# hash_key_type = "S"
# range_key = "sessionUuid"
# range_key_type = "S"
# server_side_encryption_enabled = false
# kms_key_arn = "arn:aws:kms:ap-northeast-1:903050880728:key/e272ad3d-99c8-42c2-b4bc-e090d7d6b26c"
# point_in_time_recovery_enabled = false
# ttl_attribute_name = null
# ttl_enabled = false
# stream_enabled = false
# stream_view_type = "NEW_AND_OLD_IMAGES"
# owner_name = "cpgmteam"
# environment = "prod"

# # EC2
# instance_type    = "t2.micro"
# instance_vm_id   = "ami-0e668174d57c64015"
# instance_name    = "cpgm-prod-ec2-bastion-host"
# subnet_id        = "subnet-0f58b337bbbbdde10"

# # EKS
# # Fargate profile and selectors
# fargate_profile_name = "cpgm-prod-fargate"
# fargate_selector_namespace_default = "default"
# fargate_selector_namespace_prod = "cpgm-prod-fargate"
# fargate_selector_namespace_kube_system = "kube-system"
# private_subnet_ids = ["subnet-0d6e67b09d3fbdda9", "subnet-0f58b337bbbbdde10"]
# cluster_name              = "cpgm-prod-eks-cluster"
# cluster_role_arn          = "arn:aws:iam::903050880728:role/AmazonEKSAutoClusterRole"
# project_name              = "campmgmt"
# resource_owner_email      = "scdp@hhq.suzuki.co.jp"
# launch_template_name_prefix = "cpgm-prod-eks-fargate-lt-"
# iam_instance_profile_name   = "cpgm-prod-instance-profile"
# launch_template_tag_name    = "cpgm-prod-eks-fargate-node"
# eks_instance_type           = "t2.micro"

# # # Lambda
# # function_name = "cpgm-prod-lambda-authorizer"
# # lambda_handler = "com.cpgm.lambda.AuthorizerHandler::handleRequest"
# # lambda_runtime = "java21"
# # memory_size    = 512
# # timeout        = 30
# # lambda_zip_path = "lambda_function.zip"
# # environment_variables = {}


# # NLB
# nlb_name = "cpgm-prod-nlb"
# nlb_tags = {
#   Name = "cpgm-prod-internal-nlb"
# }
# subnets  = [
#   "subnet-0d6e67b09d3fbdda9",
#   "subnet-0f58b337bbbbdde10"
# ]

# # Service to port mapping for NLB listeners/target groups
# service_ports = {
#    cpgm_prod_auth_service             = 8081
#    cpgm_prod_segment_service          = 8082
#    cpgm_prod_webform_service          = 8083
#    cpgm_prod_template_service         = 8084
#    cpgm_prod_user_management_service  = 8085
#    cpgm_prod_campaign_service         = 8086
#    cpgm_prod_file_service             = 8087
#    cpgm_prod_scheduler_service        = 8088
#    cpgm_prod_delivery_service         = 8089
#    cpgm_prod_reporting_service        = 8090
# }

# # RDS
# subnet_group_name = "cpgm-prod-rds-postgres-subnet-group"
# db_instance_identifier = "cpgm-prod-rds-postgres-sql"
# db_engine              = "postgres"
# db_engine_version      = "18.3"
# instance_class         = "db.t4g.large"
# allocated_storage      = 20
# storage_type           = "gp2"
# db_username = "postgres"
# db_password = "Suzuki#2026"
# db_port = 5432
# vpc_security_group_ids = ["sg-034e89c680527d9e9"]
# backup_retention_period = 7

# # SNS
# topic_name = "cpgm-prod-sns-topic"
# subscription_protocol = "email"
# subscription_endpoint = "scdp@hhq.suzuki.co.jp"

# # SQS
# queue_name               = "cpgm-prod-sqs-queue"
# fifo_queue               = true
# visibility_timeout       = 30
# message_retention_period = 345600


########################################
# EventBridge Rules (MULTIPLE)
########################################
rules = {
  main_scheduler = {
    name                = "cpgm-scheduler"
    schedule_expression = "rate(1 hour)"
  }

  hourly_check = {
    name                = "cpgm-hourly-check"
    schedule_expression = "cron(0 12 * * ? *)"
  }
}

########################################
# Scheduler
########################################
schedule_group_name = "cpgm-prod-schedules"
scheduler_role_name = "cpgm-prod-eventbridge-scheduler-role"

########################################
# Lambda Artifact
# ########################################
# lambda_artifact = "lambda.zip"

########################################
# Networking (EXISTING)
########################################
# #  private_subnet_ids = [
# #    "",
# #   ""
# # ]

# lambda_sg_id = ""

########################################
# Lambdas
########################################
# lambdas = {
#   email_delivery = {
#     function_name = "cpgm-prod-lambda-email-delivery"
#     handler       = "com.cpgm.lambda.delivery.DeliveryTriggerHandler::handleRequest"
#     memory_size   = 512
#     timeout       = 60

#     environment_variables = {
#       DB_SECRET_NAME        = "cpgm-prod-rds-credentials"
#       S3_DEFAULT_BUCKET     = "cpgm-prod-s3-segment"
#       SES_CONFIGURATION_SET = "cpgm-ses-config-set"
#     }
#   }

#   quality_check = {
#     function_name = "cpgm-prod-lambda-quality-check"
#     handler       = "com.cpgm.lambda.qualitycheck.QualityCheckHandler::handleRequest"
#     memory_size   = 512
#     timeout       = 60

#     environment_variables = {
#       DB_SECRET_NAME    = "cpgm-prod-rds-credentials"
#       S3_DEFAULT_BUCKET = "cpgm-prod-s3-segment"
#     }
#   }
# }

########################################
# IAM Policy for EKS Pod
########################################
eks_policy_name = "cpgm-prod-eventbridge-custom-policy"

########################################
# Tags
########################################
# tags = {
#   Environment = "prod"
#   Project     = "campaign-manager"
# }