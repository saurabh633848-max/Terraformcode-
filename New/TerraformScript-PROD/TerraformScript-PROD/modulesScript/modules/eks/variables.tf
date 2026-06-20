# NLB EKS Pods Security Group variables
variable "nlb_eks_pods_sg_name" {
  description = "Name of the NLB EKS pods security group."
  type        = string
}

variable "nlb_eks_pods_sg_description" {
  description = "Description for the NLB EKS pods security group."
  type        = string
}

variable "nlb_eks_pods_ingress_description" {
  description = "Description for ingress rule."
  type        = string
}

variable "nlb_eks_pods_ingress_from_port" {
  description = "Ingress from port."
  type        = number
}

variable "nlb_eks_pods_ingress_to_port" {
  description = "Ingress to port."
  type        = number
}

variable "nlb_eks_pods_ingress_protocol" {
  description = "Ingress protocol."
  type        = string
}

variable "nlb_eks_pods_ingress_cidr_blocks" {
  description = "Ingress CIDR blocks."
  type        = list(string)
}

variable "nlb_eks_pods_egress_from_port" {
  description = "Egress from port."
  type        = number
}

variable "nlb_eks_pods_egress_to_port" {
  description = "Egress to port."
  type        = number
}

variable "nlb_eks_pods_egress_protocol" {
  description = "Egress protocol."
  type        = string
}

variable "nlb_eks_pods_egress_cidr_blocks" {
  description = "Egress CIDR blocks."
  type        = list(string)
}
# Fargate profile and selectors
variable "fargate_profile_name" {
  description = "Name of the EKS Fargate profile."
  type        = string
}

variable "fargate_selector_namespace_default" {
  description = "Namespace for default Fargate selector."
  type        = string
}

variable "fargate_selector_namespace_prod" {
  description = "Namespace for PROD Fargate selector."
  type        = string
}

variable "fargate_selector_namespace_kube_system" {
  description = "Namespace for kube-system Fargate selector."
  type        = string
}
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
}


variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs."
  type        = list(string)
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "cluster_role_arn" {
  description = "The ARN of the EKS cluster IAM role."
  type        = string
}

variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "resource_owner_email" {
  description = "Email of the resource owner."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)."
  type        = string
}

variable "username" {
  description = "The username for Terraform operations."
  type        = string
}

variable "launch_template_name_prefix" {
  description = "The prefix for the launch template name."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile."
  type        = string
}

variable "launch_template_tag_name" {
  description = "The tag name for the launch template."
  type        = string
}


variable "instance_type" {
  description = "The instance type for the launch template."
  type        = string
}