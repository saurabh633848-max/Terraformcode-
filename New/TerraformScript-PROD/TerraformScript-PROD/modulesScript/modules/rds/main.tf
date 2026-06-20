terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "db_instance" {
  identifier              = var.db_instance_identifier
  engine                  = var.db_engine
  engine_version          = var.db_engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.username
  password                = var.password
  port                    = var.port
  db_subnet_group_name    = var.subnet_group_name
  vpc_security_group_ids  = var.vpc_security_group_ids
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = true

  tags = {
    Name = var.db_instance_identifier
  }
}
