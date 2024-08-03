output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = module.asg.autoscaling_group_id
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.asg.autoscaling_group_name
}

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = module.asg.launch_template_id
}

output "launch_template_version" {
  description = "The version of the launch template"
  value       = module.asg.launch_template_latest_version
}
