variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}

variable "security_group_description" {
  description = "The description of the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "allowed_ingress_ips" {
  description = "List of allowed CIDR blocks for ingress traffic"
  type        = list(string)
  default     = []
}

variable "predefined_ingress_rules" {
  description = "List of ingress rules to create by name"
  type = list(string)
  default = []
}

variable "allowed_egress_ips" {
  description = "List of allowed CIDR blocks for egress traffic"
  type        = list(string)
  default     = []
}


variable "predefined_egress_rules" {
  description = "List of egress rules to create by name"
  type = list(string)
  default = []
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
