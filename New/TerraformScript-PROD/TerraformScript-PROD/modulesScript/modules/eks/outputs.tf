
output "nlb_eks_pods_sg_id" {
  description = "The ID of the NLB EKS pods security group."
  value       = aws_security_group.nlb_eks_pods.id
}
output "eks_cluster_name" {
  description = "The name of the EKS cluster."
  value       = aws_eks_cluster.this.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster."
  value       = aws_eks_cluster.this.endpoint
}

output "eks_cluster_arn" {
  description = "The ARN of the EKS cluster."
  value       = aws_eks_cluster.this.arn
}

