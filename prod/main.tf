terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "../modules-prod/network"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  availability_zone   = var.availability_zone
}

module "wordpress" {
  source = "../modules-prod/wordpress"

  vpc_id      = module.network.vpc_id
  subnet_id   = module.network.public_subnet_id
  my_ip       = var.my_ip
  key_name    = var.key_name
  domain_name = var.domain_name
}
