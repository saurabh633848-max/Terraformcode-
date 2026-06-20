variable "aws_region" {
  description = "The AWS region where resources are deployed"
  type        = string
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "table_class" {
  description = "The storage class of the table (STANDARD or STANDARD_INFREQUENT_ACCESS)"
  type        = string
  validation {
    condition     = contains(["STANDARD", "STANDARD_INFREQUENT_ACCESS"], var.table_class)
    error_message = "Table class must be either STANDARD or STANDARD_INFREQUENT_ACCESS."
  }
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = "Billing mode must be either PROVISIONED or PAY_PER_REQUEST."
  }
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
}

variable "hash_key_type" {
  description = "The type of the hash key attribute (S, N, or B)"
  type        = string
  validation {
    condition     = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "Hash key type must be S (string), N (number), or B (binary)."
  }
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key"
  type        = string
}

variable "range_key_type" {
  description = "The type of the range key attribute (S, N, or B)"
  type        = string
  validation {
    condition     = contains(["S", "N", "B"], var.range_key_type)
    error_message = "Range key type must be S (string), N (number), or B (binary)."
  }
}

variable "server_side_encryption_enabled" {
  description = "Whether to enable server-side encryption"
  type        = bool
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key to use for server-side encryption"
  type        = string
}

variable "point_in_time_recovery_enabled" {
  description = "Whether to enable point-in-time recovery"
  type        = bool
}

variable "ttl_attribute_name" {
  description = "The name of the table attribute to store the TTL timestamp"
  type        = string
}

variable "ttl_enabled" {
  description = "Whether TTL is enabled"
  type        = bool
}

variable "stream_enabled" {
  description = "Whether DynamoDB Streams are enabled"
  type        = bool
}

variable "stream_view_type" {
  description = "The stream view type (KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES)"
  type        = string
  validation {
    condition     = contains(["KEYS_ONLY", "NEW_IMAGE", "OLD_IMAGE", "NEW_AND_OLD_IMAGES"], var.stream_view_type)
    error_message = "Stream view type must be one of: KEYS_ONLY, NEW_IMAGE, OLD_IMAGE, NEW_AND_OLD_IMAGES."
  }
}

variable "owner_name" {
  description = "Owner of the DynamoDB table"
  type        = string
}

variable "environment" {
  description = "Environment tag for the DynamoDB table"
  type        = string
}

variable "username" {
  description = "The username for Terraform operations."
  type        = string 
}
