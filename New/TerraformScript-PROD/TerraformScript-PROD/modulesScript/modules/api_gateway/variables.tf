variable "lambda_authorizer_name" {
  description = "Name of the Lambda authorizer."
  type        = string
}
variable "aws_region" {
  description = "AWS region to deploy the API Gateway"
  type        = string
}

variable "api_name" {
  description = "Name of the REST API"
  type        = string
}

variable "api_description" {
  description = "Description of the REST API"
  type        = string
}

variable "endpoint_type" {
  description = "Endpoint type for the API (EDGE, REGIONAL, or PRIVATE)"
  type        = string
}

variable "stage_name" {
  description = "Name of the deployment stage"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "username" {
  description = "Username for Terraform operations"
  type        = string
}
