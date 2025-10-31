

module "opensearch" {
  source                                    = "../../../modules/opensearch"
  account_id                                = var.account_id
  opensearch_secret_name                    = var.opensearch_secret_name
  ip_address_type                           = var.ip_address_type
  opensearch_instance_type                  = var.opensearch_instance_type
  opensearch_instance_count                 = var.opensearch_instance_count
  dedicated_master_enabled                  = var.dedicated_master_enabled
  master_instance_type                      = var.master_instance_type
  master_instance_count                     = var.master_instance_count
  zone_awareness_enabled                    = var.zone_awareness_enabled
  availability_zone_count                   = var.availability_zone_count
  multi_az_with_standby_enabled             = var.multi_az_with_standby_enabled
  opensearch_volume_size                    = var.opensearch_volume_size
  opensearch_log_retention_days             = var.opensearch_log_retention_days
  allowed_aws_account_ids                   = var.allowed_aws_account_ids
  opensearch_auto_software_update_enabled   = var.opensearch_auto_software_update_enabled
  auto_tune_enabled                         = var.auto_tune_enabled
  auto_tune_rollback_on_disable             = var.auto_tune_rollback_on_disable
  maintenance_schedule                      = var.maintenance_schedule
  off_peak_window_enabled                   = var.off_peak_window_enabled
  off_peak_window_minutes                   = var.off_peak_window_minutes
  off_peak_window_hours                     = var.off_peak_window_hours
  opensearch_tags                           = var.opensearch_tags
  domain_name                               = var.domain_name
  opensearch_engine_version                 = var.opensearch_engine_version
  customer_name                             = var.customer_name
  backend_bucket                            = var.backend_bucket
  region                                    = var.region
  backend_path                              = var.backend_path
  environment                               = var.environment
  #role_arn                                 = var.role_arn
}
