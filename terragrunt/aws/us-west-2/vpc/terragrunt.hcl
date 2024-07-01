locals {
  base_source = "tfr:///terraform-aws-modules/vpc/aws?version=5.8.1"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include {
  path = find_in_parent_folders()
}

include "providers" {
  path = find_in_parent_folders("providers.hcl")
}


terraform {
  source = local.base_source
}

inputs = {
  azs = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets = ["10.34.0.0/24", "10.34.1.0/24", "10.34.2.0/24"]
  private_subnets = ["10.34.4.0/22", "10.34.8.0/22", "10.34.12.0/22"]
  enable_nat_gateway = true
  single_nat_gateway = true
}