terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_sqs_queue" "this" {
  name                       = var.fifo_queue ? "${var.queue_name}.fifo" : var.queue_name
  fifo_queue                 = var.fifo_queue
  visibility_timeout_seconds = var.visibility_timeout
  message_retention_seconds  = var.message_retention_period

  tags = {
    Name        = var.queue_name
    Project     = var.project_name
    Owner       = var.resource_owner_email
    Environment = var.environment
    Username    = var.username
  }
}
