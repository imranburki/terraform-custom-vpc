provider "aws" {
  region = "us-east-1"
}

module "network" {
  source = "../../modules/network"
  vpc_cidr = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone = var.availability_zone
}