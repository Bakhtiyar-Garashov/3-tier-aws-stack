module "db" {
    source          = "git@github.com:terraform-aws-modules/terraform-aws-rds.git?ref=v6.8.0"
    
    identifier = var.database_identifier

    engine            = var.database_engine
    engine_version    = var.engine_version
    instance_class    = var.instance_class
    allocated_storage = var.allocated_storage

    db_name  = var.database_name
    username = var.database_username
    port     = var.database_port

    iam_database_authentication_enabled = var.iam_database_authentication_enabled

    vpc_security_group_ids = var.vpc_security_group_ids

    maintenance_window = "Mon:00:00-Mon:03:00"
    backup_window      = "03:00-06:00"

    tags = var.tags

    # DB subnet group, attach existing. 
    # using single private subnet in eu-central-1a
    create_db_subnet_group = true
    subnet_ids             = var.vpc_subnet_ids

    # Database Deletion Protection
    deletion_protection = var.deletion_protection          
}