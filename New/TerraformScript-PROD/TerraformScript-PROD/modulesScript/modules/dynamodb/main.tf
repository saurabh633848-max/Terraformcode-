terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_dynamodb_table" "dynamodb_table" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  table_class    = var.table_class
  hash_key       = var.hash_key
  range_key      = var.range_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  dynamic "attribute" {
    for_each = var.range_key != null ? [1] : []
    content {
      name = var.range_key
      type = var.range_key_type
    }
  }

  server_side_encryption {
    enabled     = var.server_side_encryption_enabled
    kms_key_arn = var.kms_key_arn
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  dynamic "ttl" {
    for_each = var.ttl_attribute_name != null ? [1] : []
    content {
      attribute_name = var.ttl_attribute_name
      enabled        = var.ttl_enabled
    }
  }

  stream_enabled   = var.stream_enabled
  stream_view_type = var.stream_enabled ? var.stream_view_type : null

  tags = {
    Name  = var.table_name
    Owner = var.owner_name
    Environment = var.environment
    Username    = var.username
  }
}
