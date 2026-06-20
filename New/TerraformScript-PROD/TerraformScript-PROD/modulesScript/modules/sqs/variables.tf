variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}

variable "queue_name" {
  description = "The name of the SQS queue."
  type        = string
}

variable "fifo_queue" {
  description = "Set to true if the SQS queue should be FIFO (First In, First Out)."
  type        = bool
  default     = true
}

variable "visibility_timeout" {
  description = "The visibility timeout in seconds for the SQS queue."
  type        = number
}

variable "message_retention_period" {
  description = "The number of seconds Amazon SQS retains a message in the queue."
  type        = number
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "resource_owner_email" {
  description = "Email of the resource owner."
  type        = string
}

variable "environment" {
  description = "The environment in which the resources are deployed (e.g., dev, production)."
  type        = string
}

variable "username" {
  description = "The username for Terraform operations."
  type        = string
}
