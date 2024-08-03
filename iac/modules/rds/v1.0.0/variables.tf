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

variable "vpc_security_group_ids" {
  type = list(string)
  description = "List of VPC security groups to associate and protect database"
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_subnet_ids" {
  type = list(string)
  description = "A list of VPC subnet IDs"
}

variable "deletion_protection" {
  type = bool
  description = "The database can't be deleted when this value is set to true"
  default = true
}
