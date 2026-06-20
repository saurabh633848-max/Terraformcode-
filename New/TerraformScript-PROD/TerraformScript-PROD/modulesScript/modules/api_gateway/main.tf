terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Example usage of username variable (add to tags or resource as needed)
# tags = merge(var.tags, { Username = var.username })

# ─── REST API Gateway ───────────────────────────────────────────────
resource "aws_api_gateway_rest_api" "this" {
  name        = var.api_name
  description = var.api_description

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  tags = var.tags
}

# ─── Example Resource (/health) ────────────────────────────────────
resource "aws_api_gateway_resource" "health" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "health"
}

# ─── GET Method on /health ──────────────────────────────────────────
resource "aws_api_gateway_method" "health_get" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.health.id
  http_method   = "GET"
  authorization = "NONE"
}

# ─── Mock Integration (returns 200 without a backend) ───────────────
resource "aws_api_gateway_integration" "health_get" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.health.id
  http_method = aws_api_gateway_method.health_get.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# ─── Method Response ────────────────────────────────────────────────
resource "aws_api_gateway_method_response" "health_get_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.health.id
  http_method = aws_api_gateway_method.health_get.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

# ─── Integration Response ──────────────────────────────────────────
resource "aws_api_gateway_integration_response" "health_get_200" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.health.id
  http_method = aws_api_gateway_method.health_get.http_method
  status_code = aws_api_gateway_method_response.health_get_200.status_code

  response_templates = {
    "application/json" = jsonencode({ message = "OK" })
  }
}

# ─── Deployment ─────────────────────────────────────────────────────
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  # Redeploy whenever any of these resources change
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.health,
      aws_api_gateway_method.health_get,
      aws_api_gateway_integration.health_get,
      aws_api_gateway_method_response.health_get_200,
      aws_api_gateway_integration_response.health_get_200,
      aws_api_gateway_integration.proxy_any,
      aws_api_gateway_integration_response.proxy_any_200,
    ]))
  }

  depends_on = [
    aws_api_gateway_integration.health_get,
    aws_api_gateway_integration_response.health_get_200,
    aws_api_gateway_integration.proxy_any,
    aws_api_gateway_integration_response.proxy_any_200,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# ─── Stage ──────────────────────────────────────────────────────────
resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.stage_name

  tags = var.tags
}

# ─── Qa Stage ─────────────────────────────────────────────────────



# ─── Additional Resource Paths and Proxy Methods ─────────────────────
locals {
  resource_paths = ["auth", "camp", "file", "template", "user"]
}

resource "aws_api_gateway_resource" "main_paths" {
  count      = length(local.resource_paths)
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = local.resource_paths[count.index]
}

resource "aws_api_gateway_resource" "proxy" {
  count      = length(local.resource_paths)
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.main_paths[count.index].id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_any" {
  count         = length(local.resource_paths)
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxy[count.index].id
  http_method   = "ANY"
  authorization = contains(["auth"], local.resource_paths[count.index]) ? "NONE" : "CUSTOM"
  authorizer_id = contains(["auth"], local.resource_paths[count.index]) ? null : aws_api_gateway_authorizer.lambda.id
}

# Lambda Authorizer Resource
resource "aws_api_gateway_authorizer" "lambda" {
  name                   = var.lambda_authorizer_name
  rest_api_id            = aws_api_gateway_rest_api.this.id
  authorizer_uri         = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.aws_region}:${data.aws_caller_identity.current.account_id}:function:cpgm-lambda-authorizer/invocations"
  authorizer_result_ttl_in_seconds = 300
  identity_source        = "method.request.header.Authorization"
  type                   = "TOKEN"
}

data "aws_caller_identity" "current" {}

resource "aws_api_gateway_integration" "proxy_any" {
  count             = length(local.resource_paths)
  rest_api_id       = aws_api_gateway_rest_api.this.id
  resource_id       = aws_api_gateway_resource.proxy[count.index].id
  http_method       = aws_api_gateway_method.proxy_any[count.index].http_method
  integration_http_method = "POST"
  type              = "MOCK" # Placeholder, update to AWS Lambda or HTTP as needed
  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

resource "aws_api_gateway_method_response" "proxy_any_200" {
  count         = length(local.resource_paths)
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxy[count.index].id
  http_method   = aws_api_gateway_method.proxy_any[count.index].http_method
  status_code   = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
  }
}

resource "aws_api_gateway_integration_response" "proxy_any_200" {
  count         = length(local.resource_paths)
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.proxy[count.index].id
  http_method   = aws_api_gateway_method.proxy_any[count.index].http_method
  status_code   = aws_api_gateway_method_response.proxy_any_200[count.index].status_code
  response_templates = {
    "application/json" = jsonencode({ message = "OK" })
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,x-actor-user-id,x-actor-role,x-actor-vertical-id,x-session-uuid'"
    "method.response.header.Access-Control-Allow-Methods" = "'GET,POST,PUT,DELETE,OPTIONS,HEAD,PATCH'"
  }
}
