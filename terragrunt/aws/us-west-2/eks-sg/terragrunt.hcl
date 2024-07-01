locals {
  base_source = "tfr:///terraform-aws-modules/security-group/aws?version=5.1.2"
  whitelist_ip = get_env("WHITELIST_IP")
}

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

terraform {
  source = local.base_source
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  name        = "els-iac-playground"
  description = "Security group for control plane eks cluster"
  vpc_id = dependency.vpc.outputs.vpc_id
  ingress_cidr_blocks = [dependency.vpc.outputs.vpc_cidr_block, local.whitelist_ip]
  ingress_rules       = ["https-443-tcp"]
}