output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "ecr_app_repository_name" {
  description = "AWS ECR repo arn"
  value = aws_ecr_repository.ecr_repo.name
}

output "github_role" {
    description = "Role to upload charts and images"
    value = module.github-oidc.oidc_role
  }
output "deploy_role" {
    description = "Role to deploy app"
    value = module.iam_assumable_role_admin
  }
