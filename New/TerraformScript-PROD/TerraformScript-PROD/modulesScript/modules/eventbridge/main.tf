########################################
# EventBridge Rule
########################################

resource "aws_cloudwatch_event_rule" "this" {
  for_each = var.rules

  name           = each.value.name
  event_bus_name = "default"

  schedule_expression = each.value.schedule_expression

  tags = var.tags
}

########################################
# Scheduler Group
########################################
resource "aws_scheduler_schedule_group" "this" {
  name = var.schedule_group_name

  tags = var.tags
}

########################################
# Scheduler Execution Role (NEW)
########################################
resource "aws_iam_role" "scheduler_role" {
  name = var.scheduler_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "scheduler.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

########################################
# Attach Lambda Invoke Policy to Scheduler Role
########################################
resource "aws_iam_role_policy" "scheduler_invoke" {
  name = "${var.scheduler_role_name}-invoke-policy"
  role = aws_iam_role.scheduler_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      for arn in var.lambda_arns : {
        Effect   = "Allow",
        Action   = ["lambda:InvokeFunction"],
        Resource = arn
      }
    ]
  })
}

########################################
# IAM POLICY FOR EKS POD
########################################
resource "aws_iam_policy" "eks_scheduler_policy" {
  name = var.eks_policy_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowSchedulerActions",
        Effect = "Allow",
        Action = [
          "scheduler:CreateSchedule",
          "scheduler:DeleteSchedule",
          "scheduler:GetSchedule",
          "scheduler:UpdateSchedule"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowPassRole",
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = aws_iam_role.scheduler_role.arn
      },
      {
        Sid    = "AllowLambdaInvoke",
        Effect = "Allow",
        Action = ["lambda:InvokeFunction"],
        Resource = var.lambda_arns
      }
    ]
  })
}






# #####################################
# # EventBridge Rule
# #####################################
# resource "aws_cloudwatch_event_rule" "rule" {
#   name           = var.rule_name
#   event_bus_name = "default"

#   schedule_expression = var.schedule_expression

#   tags = var.tags
# }

# #####################################
# # Scheduler Group
# #####################################
# resource "aws_scheduler_schedule_group" "this" {
#   name = var.schedule_group_name
#   tags = var.tags
# }

# #####################################
# # Lambda Permissions
# #####################################
# resource "aws_lambda_permission" "allow_eventbridge" {
#   for_each = var.lambda_names

#   statement_id  = "AllowExecution-${each.value}"
#   action        = "lambda:InvokeFunction"
#   function_name = each.value
#   principal     = "events.amazonaws.com"
#   source_arn    = aws_cloudwatch_event_rule.rule.arn
# }