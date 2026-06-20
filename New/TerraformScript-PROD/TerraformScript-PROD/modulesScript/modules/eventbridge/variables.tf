
variable "rules" {
  description = "Map of EventBridge rules"
  type = map(object({
    name                = string
    schedule_expression = string
  }))
}

# variable "tags" {
#   type = map(string)
# }


variable "schedule_group_name" {
  type = string
}

variable "scheduler_role_name" {
  type = string
}

variable "lambda_arns" {
  type = list(string)
}

variable "eks_policy_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}