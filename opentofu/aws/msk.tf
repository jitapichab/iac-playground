
module "msk_cluster" {
  source  = "terraform-aws-modules/msk-kafka-cluster/aws"
  version = "2.6.0"

  name                   = "msk-${local.account}"
  kafka_version          = "3.5.1"
  number_of_broker_nodes = 3
  encryption_in_transit_client_broker = "TLS_PLAINTEXT"

  broker_node_client_subnets  = module.vpc.private_subnets
  broker_node_instance_type   = "kafka.t3.small"
  broker_node_security_groups = [module.msk_sg[0].security_group_id]

  tags = local.vars.tags
}