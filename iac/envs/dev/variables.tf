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

// Module RDS

variable "database_identifier" {
   type = string
   description = "AWS console identifier of database"
}

variable "database_engine" {
   type = string
   description = "Option to use what engine to use"
   default = "mysql"

   validation {
     condition = contains(["mysql", "postgres", "oracle", "mssql"], var.database_engine)
     error_message = "DB engine options is limited to one of [mysql, postgres, oracle, mssql]"
   }


}
variable "engine_version" {
  type = string
  description = "What engine version to be provisioned for specified engine"
}

variable "instance_class" {
  type = string
  description = "The instance type supported for specified database engine to be provisioned"
}

variable "allocated_storage" {
  type = number
  description = "The amount of storage to be allocated in GB"
}

variable "database_name" {
  type = string
  description = "User selected name for the database"
}

variable "database_username" {
  type = string
  description = "User selected master username for the database"
}

variable "database_port" {
  type = string
  description = "Port for connecting to the instance"
  default = "root"
}

variable "iam_database_authentication_enabled" {
  type = bool
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  default = true
}

# variable "vpc_security_group_ids" {
#   type = list(string)
#   description = "List of VPC security groups to associate and protect database"
# }


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "deletion_protection" {
  type = bool
  description = "The database can't be deleted when this value is set to true"
  default = true
}

// Module ASG

variable "asg_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
}

variable "min_size" {
  description = "The minimum size of instances within Auto Scaling Group"
  type        = number
}

variable "max_size" {
  description = "The maximum size of instances wihtin Auto Scaling Group"
  type        = number
}

variable "desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
}

variable "health_check_type" {
  description = "The health check type for the Auto Scaling Group"
  type        = string

   validation {
     condition = contains(["EC2", "ELB"], var.health_check_type)
     error_message = "Healthcheck options is limited to one of [EC2, ELB]"
   }

}

variable "launch_template_name" {
  description = "The name of the launch template"
  type        = string
}

variable "launch_template_description" {
  description = "The description of the launch template"
  type        = string
}

variable "machine_image_id" {
  description = "The ID of the machine image (AMI) to use for the instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use for the instances"
  type        = string
}
