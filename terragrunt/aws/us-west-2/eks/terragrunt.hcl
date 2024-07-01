locals {
  base_source = "tfr:///terraform-aws-modules/eks/aws?version=20.14.0"
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

dependency "eks_sg" {
  config_path = "../eks-sg"
}

inputs = {
  cluster_name = "eks-testing-cluster"
  cluster_version = "1.30"
  cluster_endpoint_public_access  = true
  cluster_additional_security_group_ids = [dependency.eks_sg.outputs.security_group_id]

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

  vpc_id = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnets
  control_plane_subnet_ids = dependency.vpc.outputs.public_subnets

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
}