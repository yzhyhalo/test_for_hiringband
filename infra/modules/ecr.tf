resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.environment}-${var.name_prefix}-${var.ecr_name}"
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

  create_oidc_provider = true
  create_oidc_role     = true

  repositories              = ["yzhyhalo/test_for_hiringband"]
  oidc_role_attach_policies = [aws_iam_policy.git_actions.arn]
}


resource "aws_iam_policy" "git_actions" {
  name_prefix = "${var.project_name}-git-actions"
  description = "Policy to manage ECR ${var.project_name}"
  policy      = data.aws_iam_policy_document.git_actions.json
}


data "aws_iam_policy_document" "git_actions" {
  statement {
    sid    = "clusterAutoscalerAll"
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = ["*"]
  }

}
