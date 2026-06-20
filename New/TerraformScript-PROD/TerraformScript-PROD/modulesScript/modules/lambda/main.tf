resource "aws_iam_role" "lambda_role" {
  for_each = var.lambdas

  name = "${each.value.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "basic" {
  for_each = var.lambdas
  role     = aws_iam_role.lambda_role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "vpc" {
  for_each = var.lambdas
  role     = aws_iam_role.lambda_role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_lambda_function" "this" {
  for_each = var.lambdas

  function_name = each.value.function_name
  role          = aws_iam_role.lambda_role[each.key].arn

  runtime       = "java21"
  handler       = each.value.handler
  architectures = ["x86_64"]

  filename         = "${path.root}/modules/lambda/${var.lambda_artifact}"
  source_code_hash = filebase64sha256("${path.root}/modules/lambda/${var.lambda_artifact}")

  memory_size = each.value.memory_size
  timeout     = each.value.timeout

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_sg_id]
  }

  environment {
    variables = each.value.environment_variables
  }
}

# Allow Scheduler to invoke Lambda
resource "aws_lambda_permission" "scheduler" {
  for_each = var.lambdas

  statement_id  = "AllowScheduler-${each.key}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[each.key].function_name
  principal     = "scheduler.amazonaws.com"
}



# resource "aws_iam_role" "lambda_role" {
#   for_each = var.lambdas

#   name = "${each.value.function_name}-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect = "Allow",
#       Action = "sts:AssumeRole",
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       }
#     }]
#   })

#   tags = var.tags
# }

# resource "aws_iam_role_policy_attachment" "basic" {
#   for_each = var.lambdas

#   role       = aws_iam_role.lambda_role[each.key].name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# resource "aws_iam_role_policy_attachment" "vpc" {
#   for_each = var.lambdas

#   role       = aws_iam_role.lambda_role[each.key].name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
# }

# #####################################
# # Lambda Functions
# #####################################
# resource "aws_lambda_function" "this" {
#   for_each = var.lambdas

#   function_name = each.value.function_name
#   role          = aws_iam_role.lambda_role[each.key].arn

#   runtime = "java21"
#   handler = each.value.handler

#   architectures = ["x86_64"]

#   memory_size = each.value.memory_size
#   timeout     = each.value.timeout

#   filename         = var.lambda_artifact
#   source_code_hash = filebase64sha256(var.lambda_artifact)

#   vpc_config {
#     subnet_ids         = var.private_subnet_ids
#     security_group_ids = [var.lambda_sg_id]
#   }

#   environment {
#     variables = each.value.environment_variables
#   }

#   tags = var.tags
# }

# #####################################
# # CloudWatch Logs
# #####################################
# resource "aws_cloudwatch_log_group" "logs" {
#   for_each = var.lambdas

#   name              = "/aws/lambda/${each.value.function_name}"
#   retention_in_days = 14

#   tags = var.tags
# }