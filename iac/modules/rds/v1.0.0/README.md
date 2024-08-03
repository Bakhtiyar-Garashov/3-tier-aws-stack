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
| <a name="module_db"></a> [db](#module\_db) | git@github.com:terraform-aws-modules/terraform-aws-rds.git | v6.8.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The amount of storage to be allocated in GB | `number` | n/a | yes |
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | Option to use what engine to use | `string` | `"mysql"` | no |
| <a name="input_database_identifier"></a> [database\_identifier](#input\_database\_identifier) | AWS console identifier of database | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | User selected name for the database | `string` | n/a | yes |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | Port for connecting to the instance | `string` | `"root"` | no |
| <a name="input_database_username"></a> [database\_username](#input\_database\_username) | User selected master username for the database | `string` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | The database can't be deleted when this value is set to true | `bool` | `true` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | What engine version to be provisioned for specified engine | `string` | n/a | yes |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled | `bool` | `true` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | The instance type supported for specified database engine to be provisioned | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate and protect database | `list(string)` | n/a | yes |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | A list of VPC subnet IDs | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_id"></a> [database\_id](#output\_database\_id) | The ID of AWS RDS database |
<!-- END_TF_DOCS -->