module "vpc" {
  source = "../../modules/vpc/v1.0.0"

  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source = "../../modules/eks/v1.0.0"

  cluster_name                     = var.cluster_name
  cluster_version                  = var.cluster_version
  cluster_endpoint_public_access   = var.cluster_endpoint_public_access
  vpc_id                           = module.vpc.vpc_id
  subnet_ids                       = module.vpc.private_subnets
  instance_types                   = var.instance_types
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "rds" {
  source = "../../modules/rds/v1.0.0"

  database_identifier = var.database_identifier
  database_engine = var.database_engine
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  database_name = var.database_name
  database_username = var.database_username
  database_port = var.database_port
  iam_database_authentication_enabled = var.cluster_endpoint_public_access
  // TODO: develop security group module and reference
  vpc_security_group_ids = [""]
  vpc_subnet_ids = [module.vpc.private_subnets]
  deletion_protection = true
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}