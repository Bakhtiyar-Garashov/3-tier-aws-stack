module "vpc" {
  source = "../../modules/vpc/v1.0.0"

  vpc_name             = "custom-vpc"
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}
