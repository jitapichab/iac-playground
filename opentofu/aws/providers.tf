locals {
  account = terraform.workspace
  vars     = yamldecode(file("vars/${local.account}.yaml"))
}

provider "aws" {
  region  = local.vars.region
  profile = local.account
}