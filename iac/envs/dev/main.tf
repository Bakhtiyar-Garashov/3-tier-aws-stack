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


module "sg" {
  source = "../../modules/security-group/v1.0.0"

  security_group_name = var.security_group_name
  security_group_description = var.security_group_description

  vpc_id = module.vpc.vpc_id

  allowed_ingress_ips = var.allowed_ingress_ips

  predefined_ingress_rules = var.predefined_ingress_rules

  allowed_egress_ips = var.allowed_ingress_ips

  predefined_egress_rules = var.predefined_egress_rules

  tags = {
      Terraform   = "true"
    Environment = "dev"
  }

  depends_on = [ module.vpc ]

}
