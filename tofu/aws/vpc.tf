module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = local.account
  cidr = local.vars.cidr

  azs             = local.vars.azs
  private_subnets = local.vars.private_subnets
  public_subnets  = local.vars.public_subnets

  enable_nat_gateway = true

  tags = local.vars.tags
}
