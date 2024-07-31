## Terraform AWS VPC Module Wrapper

### Overview
This module is a wrapper around the Terraform AWS VPC module, designed to simplify the creation and management of AWS Virtual Private Clouds (VPCs) in your infrastructure. It provides a higher-level abstraction, allowing for easier configuration and deployment of VPCs with sensible defaults and customizable options.

### Usage
To use this module, include the following in your Terraform configuration:

```hcl

module "vpc" {
  source = "<path-to-your-wrapper-module>"

  # Customizable variables
  vpc_name        = "my-vpc"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true

  # Add any additional configuration variables here
}

```