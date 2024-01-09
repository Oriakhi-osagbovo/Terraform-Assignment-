terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  azs        = var.azs
}

module "instance" {
  source = "./modules/instance"
  for_each = { for env, config in var.environments : env => config }
  environment = each.key
  region     = var.aws_regions[each.key]
  vpc_id     = module.vpc.vpc_id
  azs        = var.azs

  tags = {
    Environment = each.key
  }
}
