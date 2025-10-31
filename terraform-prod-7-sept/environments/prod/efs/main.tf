module "efs" {
  source             = "../../../modules/efs"
  customer_name       = var.customer_name
  efs-security-group = var.efs-security-group
  backend_bucket     = var.backend_bucket
  region             = var.region
  efs_tags = var.efs_tags
  backend_path       = var.backend_path
  environment        = var.environment
  #role_arn           = var.role_arn
}
