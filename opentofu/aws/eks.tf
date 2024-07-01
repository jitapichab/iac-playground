module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.14.0"

  count = local.vars.eks_enabled ? 1 : 0

  cluster_name    = local.vars.cluster_name
  cluster_version = local.vars.eks_version

  cluster_endpoint_public_access  = true
  cluster_additional_security_group_ids = [module.control_plane_sg[0].security_group_id]

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t3.large"]
      capacity_type  = "SPOT"
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = local.vars.tags
}