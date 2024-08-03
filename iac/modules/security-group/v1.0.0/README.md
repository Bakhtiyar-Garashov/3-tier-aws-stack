<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.30 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | git@github.com:terraform-aws-modules/terraform-aws-security-group.git | v5.1.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_egress_ips"></a> [allowed\_egress\_ips](#input\_allowed\_egress\_ips) | List of allowed CIDR blocks for egress traffic | `list(string)` | `[]` | no |
| <a name="input_allowed_ingress_ips"></a> [allowed\_ingress\_ips](#input\_allowed\_ingress\_ips) | List of allowed CIDR blocks for ingress traffic | `list(string)` | `[]` | no |
| <a name="input_predefined_egress_rules"></a> [predefined\_egress\_rules](#input\_predefined\_egress\_rules) | List of egress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_predefined_ingress_rules"></a> [predefined\_ingress\_rules](#input\_predefined\_ingress\_rules) | List of ingress rules to create by name | `list(string)` | `[]` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group | `string` | `"Managed by Terraform"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name of the security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the security group will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
<!-- END_TF_DOCS -->