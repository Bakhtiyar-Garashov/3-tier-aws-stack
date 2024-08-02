// Global 

variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-central-1"
}

// Module VPC
variable "vpc_name" {
  description = "The name you want for the VPC"
  type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "enable_nat_gateway" {
  description = "Flag to enable/disable NAT Gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Flag to create a single NAT Gateway across all AZs"
  type        = bool
  default     = true
}



// Module EKS

variable "cluster_name" {
  description = "The name you want for EKS cluster"
  type = string
  default = "my-eks-cluster"
}

variable "cluster_version" {
  description = "EKS K8S version to be provisioned"
  type = string
  default = "1.30"
}

variable "cluster_endpoint_public_access" {
  description = "Whether or not to enable EKS API endpoints public access"
  type = bool
  default = false
}

variable "instance_types" {
  description = "EC2 worker node instance types"
  type = list(string)
  default = [ "t3.micro" ]
  
}
