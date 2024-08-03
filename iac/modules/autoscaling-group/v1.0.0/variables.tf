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

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
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

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
}
