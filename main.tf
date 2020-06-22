# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "gudiao-labs-tfstates-terraform"
    key    = "modules/terraformt.tfstate"
    region = "us-east-1"
  }
}

module "vpc" {
  source = "./vpc"

  name = "gudiao-labs"
  cidr = "10.0.0.0/16"

  azs               = ["us-east-1a", "us-east-1b", "us-east-1c"]

  private_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets    = ["10.0.11.0/24", "10.0.12.0/24"]
  database_subnets  = ["10.0.21.0/24", "10.0.22.0/24"]
  mgmt_subnets      = ["10.0.31.0/24", "10.0.32.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_group = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}