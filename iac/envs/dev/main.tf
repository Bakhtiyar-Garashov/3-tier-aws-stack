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

# module "eks" {
#   source = "../../modules/eks/v1.0.0"

#   cluster_name                     = var.cluster_name
#   cluster_version                  = var.cluster_version
#   cluster_endpoint_public_access   = var.cluster_endpoint_public_access
#   vpc_id                           = module.vpc.vpc_id
#   subnet_ids                       = module.vpc.private_subnets
#   instance_types                   = var.instance_types
#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }

#   depends_on = [ module.vpc ]
# }

# module "rds" {
#   source = "../../modules/rds/v1.0.0"

#   database_identifier = var.database_identifier
#   database_engine = var.database_engine
#   engine_version = var.engine_version
#   instance_class = var.instance_class
#   allocated_storage = var.allocated_storage
#   database_name = var.database_name
#   database_username = var.database_username
#   database_port = var.database_port
#   iam_database_authentication_enabled = var.cluster_endpoint_public_access
#   vpc_security_group_ids = module.sg.security_group_id
#   vpc_subnet_ids = module.vpc.private_subnets
#   deletion_protection = true
#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
#   depends_on = [ module.vpc ]
# }

# module "asg" {
#   source = "../../modules/autoscaling-group/v1.0.0"

#   asg_name = var.asg_name

#   min_size                  = var.min_size
#   max_size                  = var.max_size
#   desired_capacity          = var.desired_capacity

#   health_check_type         = var.health_check_type
  
#   vpc_zone_identifier       = module.vpc.private_subnets
  
#   # Launch template
#   launch_template_name        = var.launch_template_name
#   launch_template_description = var.launch_template_description

#   machine_image_id = var.machine_image_id
#   instance_type     = var.instance_type

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
#   depends_on = [ module.vpc ]
# } 

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