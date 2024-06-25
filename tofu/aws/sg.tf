module "msk_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  count = local.vars.msk_enabled ? 1 : 0

  name        = "msk-${local.account}"
  description = "Security group for control plane eks cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules       = ["kafka-broker-tcp", "zookeeper-2181-tcp"]

  tags = local.vars.tags
}

module "control_plane_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"

  count = local.vars.eks_enabled ? 1 : 0

  name        = "eks-control-plane-${local.account}"
  description = "Security group for control plane eks cluster"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [module.vpc.vpc_cidr_block,local.vars.my_public_cidr]
  ingress_rules       = ["https-443-tcp"]

  tags = local.vars.tags

}