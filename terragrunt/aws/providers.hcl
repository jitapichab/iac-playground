 locals {
  region_vars       =  yamldecode(file(find_in_parent_folders("region.yaml")))
  bucket_name       = get_env("BUCKET_NAME")
  region            = local.region_vars.aws_region
}

remote_state {
  backend   = "s3"
  generate  = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config    = {
    bucket         = local.bucket_name
    key            = "iac-playground/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
    profile        = "iac-playground"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "${local.region}"
  profile = "iac-playground"
}
EOF
}

inputs = local.region_vars
