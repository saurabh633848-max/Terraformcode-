output "db_instance_endpoint" {
  description = "The connection endpoint for the database instance"
  value       = aws_db_instance.db_instance.endpoint
}

output "db_instance_arn" {
  description = "The ARN of the database instance"
  value       = aws_db_instance.db_instance.arn
}

output "db_instance_identifier" {
  description = "The identifier of the database instance"
  value       = aws_db_instance.db_instance.identifier
}

output "db_instance_status" {
  description = "The current status of the database instance"
  value       = aws_db_instance.db_instance.status
}

output "db_instance_address" {
  description = "The address of the database instance"
  value       = aws_db_instance.db_instance.address
}

output "db_instance_port" {
  description = "The port on which the database instance is listening"
  value       = aws_db_instance.db_instance.port
}
