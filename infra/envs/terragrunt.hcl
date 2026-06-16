remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
    }
  config = {
    bucket         = "${get_env("GITHUB_REF","dev")}-${local.project}-tfstate"
    region         = "${ get_env("AWS_DEFAULT_REGION","us-west-2") }"
    encrypt        = true
    key            = "${path_relative_to_include()}/tfstate.tfstate"
    dynamodb_table = "${get_env("GITHUB_REF","dev")}-${local.project}-tfstate"

    #profile        = "${ get_env("AWS_DEFAULT_REGION", "us-west-2") }"
  }

}
terraform {
  source = "../../modules/"
}

locals {
  project = "test4hiringband"
}
#inputs = {
#  project = local.project
#}
