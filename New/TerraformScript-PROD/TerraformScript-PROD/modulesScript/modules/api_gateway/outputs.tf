output "api_id" {
  description = "ID of the REST API"
  value       = aws_api_gateway_rest_api.this.id
}

output "api_execution_arn" {
  description = "Execution ARN of the REST API"
  value       = aws_api_gateway_rest_api.this.execution_arn
}

output "invoke_url" {
  description = "Base invoke URL of the deployed stage"
  value       = aws_api_gateway_stage.this.invoke_url
}

output "stage_name" {
  description = "Deployed stage name"
  value       = aws_api_gateway_stage.this.stage_name
}
