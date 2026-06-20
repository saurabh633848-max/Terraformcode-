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

resource "aws_sns_topic" "this" {
  name = var.topic_name
  tags = {
    Username = var.username
  }
}

resource "aws_sns_topic_subscription" "this" {
  topic_arn = aws_sns_topic.this.arn
  protocol  = var.subscription_protocol
  endpoint  = var.subscription_endpoint
}
