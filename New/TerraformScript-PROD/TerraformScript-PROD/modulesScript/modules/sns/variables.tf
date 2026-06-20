variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "topic_name" {
  description = "Name of the SNS topic"
  type        = string
}

variable "subscription_protocol" {
  description = "Protocol for the SNS subscription (e.g., email, sms, lambda)"
  type        = string
}

variable "subscription_endpoint" {
  description = "Endpoint for the SNS subscription (e.g., email address)"
  type        = string
}

variable "username" {
  description = "The username for Terraform operations."
  type        = string 
}
