// Version and provider configuration
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

  default_tags {
    tags = {
      Project     = var.project_name
      Owner       = var.resource_owner_email
      Environment = var.environment
    }
  }
}

# Example usage of username variable (add to tags or resource as needed)
# To use the username in a tag, add the following line to the tags block:
# Username = var.username

// Existing resources
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }
}

resource "aws_launch_template" "eks_nodes" {
  name_prefix   = var.launch_template_name_prefix
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  # vpc_security_group_ids removed

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.launch_template_tag_name
    }
  }
}

  # EKS Fargate Profile for PROD workloads
  resource "aws_eks_fargate_profile" "prod" {
    cluster_name           = aws_eks_cluster.this.name
    fargate_profile_name   = var.fargate_profile_name
    pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
    subnet_ids             = var.private_subnet_ids

    depends_on = [aws_eks_cluster.this]

    selector {
      namespace = var.fargate_selector_namespace_default
    }
    selector {
      namespace = var.fargate_selector_namespace_prod
    }
    selector {
      namespace = var.fargate_selector_namespace_kube_system
    }

    tags = {
      Name        = var.fargate_profile_name
      Environment = var.environment
      Project     = var.project_name
    }
  }

  # IAM Role for Fargate Pod Execution
  resource "aws_iam_role" "fargate_pod_execution_role" {
    name = "${var.cluster_name}-fargate-pod-execution-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect = "Allow"
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }]
    })
  }

  resource "aws_iam_role_policy_attachment" "fargate_pod_execution_role_policy" {
    role       = aws_iam_role.fargate_pod_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  }

  # IAM Role for AWS Load Balancer Controller (IRSA)
  resource "aws_iam_role" "lb_controller" {
    name = "${var.cluster_name}-lb-controller-role"

    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [{
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.eks.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }]
    })
  }


  # OIDC provider for EKS (required for IRSA)
  resource "aws_iam_openid_connect_provider" "eks" {
    client_id_list  = ["sts.amazonaws.com"]
    thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0c199e200"]
    url             = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  }

  # Data source for EKS cluster (for OIDC)
  data "aws_eks_cluster" "cluster" {
    name = aws_eks_cluster.this.name
  }


  # Helm provider for deploying AWS Load Balancer Controller
  provider "helm" {
    kubernetes = {
      host                   = data.aws_eks_cluster.cluster.endpoint
      cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
      token                  = data.aws_eks_cluster_auth.cluster.token
    }
  }

  # Data source for EKS cluster authentication
  data "aws_eks_cluster_auth" "cluster" {
    name = aws_eks_cluster.this.name
  }

  # Helm release for AWS Load Balancer Controller

  # Security Group for NLB traffic to EKS pods
  resource "aws_security_group" "nlb_eks_pods" {
    name        = var.nlb_eks_pods_sg_name
    description = var.nlb_eks_pods_sg_description
    vpc_id      = var.vpc_id

    ingress {
      description = var.nlb_eks_pods_ingress_description
      from_port   = var.nlb_eks_pods_ingress_from_port
      to_port     = var.nlb_eks_pods_ingress_to_port
      protocol    = var.nlb_eks_pods_ingress_protocol
      cidr_blocks = var.nlb_eks_pods_ingress_cidr_blocks
    }

    egress {
      from_port   = var.nlb_eks_pods_egress_from_port
      to_port     = var.nlb_eks_pods_egress_to_port
      protocol    = var.nlb_eks_pods_egress_protocol
      cidr_blocks = var.nlb_eks_pods_egress_cidr_blocks
    }

    tags = {
      Name        = var.nlb_eks_pods_sg_name
      Environment = var.environment
      Project     = var.project_name
    }
  }


  # Data source for AWS account ID (for TargetGroupBinding)
  data "aws_caller_identity" "current" {}

  # (Optional) Attach this security group to your Fargate profile or node groups as needed

