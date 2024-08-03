module "security_group" {
  source = "git@github.com:terraform-aws-modules/terraform-aws-security-group.git?ref=v5.1.2"

  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = var.allowed_ingress_ips

  ingress_rules = var.predefined_ingress_rules

  egress_cidr_blocks = var.allowed_egress_ips
  egress_rules = var.predefined_egress_rules

  tags = var.tags
}
