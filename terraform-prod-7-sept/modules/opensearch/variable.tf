variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "account_id" {
  description = "AWS Account ID"
  type        = string
}

variable "customer_name" {
  description = "Customer/project name"
  type        = string
}

variable "environment" {
  description = "Environment (dev, qa, prod)"
  type        = string
}

variable "backend_bucket" {
  description = "S3 bucket name for remote backend state"
  type        = string
}

variable "backend_path" {
  description = "Path (prefix) in the S3 bucket for backend state"
  type        = string
}

variable "opensearch_secret_name" {
  description = "Secrets Manager secret name for OpenSearch credentials"
  type        = string
}

variable "domain_name" {
  description = "OpenSearch domain name"
  type        = string
}

variable "opensearch_engine_version" {
  description = "OpenSearch engine version"
  type        = string
}

variable "ip_address_type" {
  description = "IP address type for OpenSearch (ipv4 or dualstack)"
  type        = string
}

variable "opensearch_instance_type" {
  description = "Instance type for data nodes"
  type        = string
}

variable "opensearch_instance_count" {
  description = "Number of data nodes"
  type        = number
}

variable "dedicated_master_enabled" {
  description = "Enable dedicated master nodes"
  type        = bool
}

variable "master_instance_type" {
  description = "Instance type for dedicated master nodes"
  type        = string
}

variable "master_instance_count" {
  description = "Number of dedicated master nodes"
  type        = number
}

variable "zone_awareness_enabled" {
  description = "Enable zone awareness (multi-AZ)"
  type        = bool
}

variable "availability_zone_count" {
  description = "Number of AZs to use (2 or 3)"
  type        = number
}

variable "multi_az_with_standby_enabled" {
  description = "Enable Multi-AZ with standby"
  type        = bool
}

variable "opensearch_volume_size" {
  description = "EBS volume size (GB)"
  type        = number
}

variable "opensearch_log_retention_days" {
  description = "Retention in days for CloudWatch log groups"
  type        = number
}

variable "allowed_aws_account_ids" {
  description = "List of AWS account IDs allowed in OpenSearch access policy"
  type        = list(string)
}

variable "opensearch_auto_software_update_enabled" {
  description = "Enable automatic software updates"
  type        = bool
}

variable "auto_tune_enabled" {
  description = "Enable Auto-Tune"
  type        = bool
}

variable "auto_tune_rollback_on_disable" {
  description = "Rollback Auto-Tune changes when disabling"
  type        = string
}

variable "maintenance_schedule" {
  description = "Maintenance schedule for Auto-Tune"
  type = object({
    start_at                       = string
    duration_value                 = number
    duration_unit                  = string
    cron_expression_for_recurrence = string
  })
}

variable "off_peak_window_enabled" {
  description = "Enable off-peak window"
  type        = bool
}

variable "off_peak_window_hours" {
  description = "Start hour for off-peak window"
  type        = number
}

variable "off_peak_window_minutes" {
  description = "Start minute for off-peak window"
  type        = number
}

variable "opensearch_tags" {
  description = "Custom tags for OpenSearch domain"
  type        = map(string)
}
