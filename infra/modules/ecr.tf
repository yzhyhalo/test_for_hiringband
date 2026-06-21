resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.environment}-${var.name_prefix}-app"
  image_scanning_configuration {
    scan_on_push = true
  }

}

#module "iam_oidc_provider" {
#  source    = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"
#
#  url = "https://token.actions.githubusercontent.com"
#
#
#
#}

module "github-oidc" {
  source  = "terraform-module/github-oidc-provider/aws"
  version = "~> 1"
  role_name = "github-${var.environment}-oidc-${var.project_name}"
  create_oidc_provider = true
  create_oidc_role     = true

  repositories              = ["yzhyhalo/test_for_hiringband"]
  oidc_role_attach_policies = [aws_iam_policy.git_actions_ecr.arn,aws_iam_policy.git_actions_eks.arn]
}


resource "aws_iam_policy" "git_actions_ecr" {
  name_prefix = "${var.project_name}-git-actions"
  description = "Policy to manage ECR ${var.project_name}"
  policy      = data.aws_iam_policy_document.git_actions_ecr.json
}

resource "aws_iam_policy" "git_actions_eks" {
  name_prefix = "${var.project_name}-git-actions"
  description = "Policy to manage ECR ${var.project_name}"
  policy      = data.aws_iam_policy_document.git_actions_eks.json
}


data "aws_iam_policy_document" "git_actions_eks" {
  statement {
    sid    = ""
    effect = "Allow"

    actions = [
      "eks:*",
    ]

    resources = [
      module.eks.cluster_arn 
    ]
  
  
  }
}

data "aws_iam_policy_document" "git_actions_ecr" {
  statement {
    sid    = ""
    effect = "Allow"

    actions = [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:DescribeImages",
                "ecr:BatchGetImage",
                "ecr:GetLifecyclePolicy",
                "ecr:GetLifecyclePolicyPreview",
                "ecr:ListTagsForResource",
                "ecr:DescribeImageScanFindings",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:PutImage"
    ]

    resources = ["*"]
  
  }

}
