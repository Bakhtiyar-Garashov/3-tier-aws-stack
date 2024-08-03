<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.30 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_asg"></a> [asg](#module\_asg) | git@github.com:terraform-aws-modules/terraform-aws-autoscaling.git | v7.7.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | The name of the Auto Scaling Group | `string` | n/a | yes |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The desired capacity of the Auto Scaling Group | `number` | n/a | yes |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | The health check type for the Auto Scaling Group | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use for the instances | `string` | n/a | yes |
| <a name="input_launch_template_description"></a> [launch\_template\_description](#input\_launch\_template\_description) | The description of the launch template | `string` | n/a | yes |
| <a name="input_launch_template_name"></a> [launch\_template\_name](#input\_launch\_template\_name) | The name of the launch template | `string` | n/a | yes |
| <a name="input_machine_image_id"></a> [machine\_image\_id](#input\_machine\_image\_id) | The ID of the machine image (AMI) to use for the instances | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of instances wihtin Auto Scaling Group | `number` | n/a | yes |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of instances within Auto Scaling Group | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resources | `map(string)` | n/a | yes |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | A list of subnet IDs to launch resources in | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_asg_id"></a> [asg\_id](#output\_asg\_id) | The ID of the Auto Scaling Group |
| <a name="output_asg_name"></a> [asg\_name](#output\_asg\_name) | The name of the Auto Scaling Group |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | The ID of the launch template |
| <a name="output_launch_template_version"></a> [launch\_template\_version](#output\_launch\_template\_version) | The version of the launch template |
<!-- END_TF_DOCS -->