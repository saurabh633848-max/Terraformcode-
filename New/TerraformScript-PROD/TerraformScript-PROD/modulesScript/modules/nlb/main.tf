provider "aws" {
  region = "ap-northeast-1" # Change to your desired AWS region
}

# Dynamically create target groups and listeners for each service/port
locals {
  service_ports = var.service_ports
}

resource "aws_lb_target_group" "service" {
  for_each    = local.service_ports
    name        = replace(substr("${replace(each.key, "_", "-")}", 0, 32), "-$", "")
  port        = each.value
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    protocol = "TCP"
    port     = each.value
  }
  stickiness {
    enabled = false
    type    = "source_ip"
  }
  tags = {
    Name = "${replace(each.key, "_", "-")}-prod"
  }
}

resource "aws_lb_listener" "service" {
  for_each            = local.service_ports
  load_balancer_arn   = aws_lb.cpgm_nlb.arn
  port                = each.value
  protocol            = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service[each.key].arn
  }
}

############################################
# NETWORK LOAD BALANCER
############################################

resource "aws_lb" "cpgm_nlb" {
  name               = var.nlb_name
  internal           = true
  load_balancer_type = "network"
  subnets            = var.subnets
  enable_deletion_protection = false
  tags               = var.nlb_tags
}



