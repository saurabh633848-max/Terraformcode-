output "lambda_arns" {
  value = {
    for k, v in aws_lambda_function.this : k => v.arn
  }
}

output "lambda_names" {
  value = {
    for k, v in aws_lambda_function.this : k => v.function_name
  }
}