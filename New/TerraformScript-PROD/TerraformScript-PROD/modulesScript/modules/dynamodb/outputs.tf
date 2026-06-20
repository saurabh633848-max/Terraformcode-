output "table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.name
}

output "table_id" {
  description = "The ID of the DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.id
}

output "table_arn" {
  description = "The ARN of the DynamoDB table"
  value       = aws_dynamodb_table.dynamodb_table.arn
}

output "table_stream_arn" {
  description = "The ARN of the Table Stream (only if streams are enabled)"
  value       = aws_dynamodb_table.dynamodb_table.stream_arn
}

output "table_stream_label" {
  description = "A timestamp, in ISO 8601 format, for this stream"
  value       = aws_dynamodb_table.dynamodb_table.stream_label
}

output "table_hash_key" {
  description = "The hash (partition) key of the table"
  value       = aws_dynamodb_table.dynamodb_table.hash_key
}

output "table_range_key" {
  description = "The range (sort) key of the table"
  value       = aws_dynamodb_table.dynamodb_table.range_key
}

output "table_class" {
  description = "The storage class of the table"
  value       = aws_dynamodb_table.dynamodb_table.table_class
}

output "billing_mode" {
  description = "The billing mode of the table"
  value       = aws_dynamodb_table.dynamodb_table.billing_mode
}

output "aws_region" {
  description = "The AWS region where resources are deployed"
  value       = var.aws_region
}

output "table_owner" {
  description = "The owner of the DynamoDB table"
  value       = var.owner_name
}

output "environment" {
  description = "The environment tag of the DynamoDB table"
  value       = var.environment
}

output "point_in_time_recovery_enabled" {
  description = "Whether point-in-time recovery is enabled"
  value       = var.point_in_time_recovery_enabled
}

output "server_side_encryption_enabled" {
  description = "Whether server-side encryption is enabled"
  value       = var.server_side_encryption_enabled
}

output "stream_enabled" {
  description = "Whether DynamoDB Streams are enabled"
  value       = var.stream_enabled
}
