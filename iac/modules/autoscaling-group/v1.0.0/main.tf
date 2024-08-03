module "asg" {
  source     = "git@github.com:terraform-aws-modules/terraform-aws-autoscaling.git?ref=v7.7.0"

  # Autoscaling group
  name = var.asg_name

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity

  health_check_type         = var.health_check_type
  
  vpc_zone_identifier       = var.vpc_zone_identifier

  # Launch template
  launch_template_name        = var.launch_template_name
  launch_template_description = var.launch_template_description
  update_default_version      = true

  image_id          = var.machine_image_id
  instance_type     = var.instance_type
  ebs_optimized     = false
  enable_monitoring = false

  # IAM role & instance profile
  create_iam_instance_profile = true
  iam_role_name               = "asg-iam-role"
  iam_role_path               = "/ec2/"
  iam_role_description        = "Autoscaling group IAM role"
  iam_role_tags = {
    CustomIamRole = "Yes"
  }
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  instance_market_options = {
    market_type = "spot"
  }

  tags = var.tags
}