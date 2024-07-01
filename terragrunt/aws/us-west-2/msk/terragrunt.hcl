locals {
  base_source = "tfr:///terraform-aws-modules/msk-kafka-cluster/aws?version=2.6.0"
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

dependency "vpc" {
  config_path = "../vpc"
}

dependency "msk_sg" {
  config_path = "../msk-sg"
}

inputs = {
  name = "msk-iac-playground"
  kafka_version = "3.5.1"
  encryption_in_transit_client_broker = "TLS_PLAINTEXT"
  number_of_broker_nodes = 3
  broker_node_instance_type = "kafka.t3.small"
  broker_node_client_subnets = dependency.vpc.outputs.private_subnets
  broker_node_security_groups = [dependency.msk_sg.outputs.security_group_id]
}