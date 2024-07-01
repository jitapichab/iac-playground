locals {
  base_source = "tfr:///terraform-aws-modules/security-group/aws?version=5.1.2"
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
  name        = "msk-iac-playground"
  description = "Security group for MSK cluster"
  vpc_id = dependency.vpc.outputs.vpc_id
  ingress_cidr_blocks = [dependency.vpc.outputs.vpc_cidr_block]
  ingress_rules       = ["kafka-broker-tcp", "zookeeper-2181-tcp"]
}