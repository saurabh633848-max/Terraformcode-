variable "nlb_name" {
  description = "The name of the Network Load Balancer."
  type        = string
}

variable "nlb_tags" {
  description = "Tags to apply to the Network Load Balancer."
  type        = map(string)
}
variable "vpc_id" {
  description = "The VPC ID where the NLB and target groups will be deployed."
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the NLB."
  type        = list(string)
}

# Map of service names to their ports for NLB listeners/target groups
variable "service_ports" {
  description = "Map of service names to their respective ports for NLB listeners and target groups."
  type = map(number)
  default = {
    cpgm_auth_service            = 8081
    cpgm_segment_service         = 8082
    cpgm_webform_service         = 8083
    cpgm_template_service        = 8084
    cpgm_user_management_service = 8085
    cpgm_campaign_service        = 8086
    cpgm_file_service            = 8087
    cpgm_scheduler_service       = 8088
    cpgm_delivery_service        = 8089
    cpgm_reporting_service       = 8090
  }
}
