variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
}

variable "aws_username" {
  description = "AWS IAM username for Terraform operations"
  type        = string
}

variable "subnet_group_name" {
  description = "Name of the DB subnet group"
  type        = string
}

variable "db_instance_identifier" {
  description = "Unique identifier for the DB instance"
  type        = string
}

variable "db_engine" {
  description = "Database engine (e.g., postgres, mysql, mariadb)"
  type        = string
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the DB instance"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage size in GB"
  type        = number
}

variable "storage_type" {
  description = "Storage type (e.g., gp2, io1)"
  type        = string
}

variable "username" {
  description = "Master username for the DB instance"
  type        = string
}

variable "password" {
  description = "Master password for the DB instance"
  type        = string
}

variable "port" {
  description = "Port number for the DB instance"
  type        = number
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs"
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
}
