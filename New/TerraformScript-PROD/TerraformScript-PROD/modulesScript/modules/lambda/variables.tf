variable "lambda_artifact" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "lambda_sg_id" {
  type = string
}

variable "lambdas" {
  type = map(object({
    function_name = string
    handler       = string
    memory_size   = number
    timeout       = number
    environment_variables = map(string)
  }))
}

variable "tags" {
  type = map(string)
}