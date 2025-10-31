data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/vpc"
    region     = var.region
    #role_arn   = var.role_arn
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket     = var.backend_bucket
    key        = "${var.backend_path}/backend/kms"
    region     = var.region
    #role_arn   = var.role_arn
  }
}

data "aws_secretsmanager_secret" "opensearch" {
  name = "${var.opensearch_secret_name}/credentials"
}

# Retrieve the secret version (actual values)
data "aws_secretsmanager_secret_version" "opensearch_value" {
  secret_id = data.aws_secretsmanager_secret.opensearch.id
}

# Parse the secret string as JSON
locals {
  creds = jsondecode(data.aws_secretsmanager_secret_version.opensearch_value.secret_string)
}

resource "aws_cloudwatch_log_resource_policy" "opensearch_logs" {
  policy_name = "${var.customer_name}-${var.environment}-OpenSearchLogPolicy"

  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "es.amazonaws.com"
        }
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream"
        ]
        Resource = "arn:aws:logs:${var.region}:${var.account_id}:log-group:/aws/opensearch/${var.customer_name}-${var.environment}-${var.domain_name}/*"
      }
    ]
  })
}

resource "aws_security_group" "opensearch_sg" {
  name        = "${var.customer_name}-${var.environment}-opensearch-access"
  description = "Allow HTTPS access to OpenSearch"
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/opensearch/${var.customer_name}-${var.environment}-${var.domain_name}/application-logs"
  retention_in_days = var.opensearch_log_retention_days
}

resource "aws_cloudwatch_log_group" "search_slow_logs" {
  name              = "/aws/opensearch/${var.customer_name}-${var.environment}-${var.domain_name}/search-slow-logs"
  retention_in_days = var.opensearch_log_retention_days
}

resource "aws_cloudwatch_log_group" "index_slow_logs" {
  name              = "/aws/opensearch/${var.customer_name}-${var.environment}-${var.domain_name}/index-slow-logs"
  retention_in_days = var.opensearch_log_retention_days
}

locals {
  constant_opensearch_cluster_tags = {
    managedBy = "Terraform"
  }
}

resource "aws_opensearch_domain" "main" {
  domain_name    = var.domain_name
  engine_version = var.opensearch_engine_version
  ip_address_type = var.ip_address_type

  tags = merge(
    local.constant_opensearch_cluster_tags,
    var.opensearch_tags
  )

  cluster_config {
    instance_type            = var.opensearch_instance_type
    instance_count           = var.opensearch_instance_count
    dedicated_master_enabled = var.dedicated_master_enabled
    dedicated_master_type    = var.master_instance_type
    dedicated_master_count   = var.master_instance_count
    zone_awareness_enabled   = var.zone_awareness_enabled

    zone_awareness_config {
      availability_zone_count = var.availability_zone_count
    }
    multi_az_with_standby_enabled = var.multi_az_with_standby_enabled
  }


  ebs_options {
    ebs_enabled = true
    volume_size = var.opensearch_volume_size
    volume_type = "gp3"
    iops        = 6000
    throughput  = 500
  }

  vpc_options {
    subnet_ids         = data.terraform_remote_state.vpc_state.outputs.private_subnet_ids
    security_group_ids = [aws_security_group.opensearch_sg.id]
  }

  access_policies = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = var.allowed_aws_account_ids
        },
        Action   = "es:*",
        Resource = "arn:aws:es:${var.region}:${var.account_id}:domain/${var.domain_name}/*"
      }
    ]
  })

  encrypt_at_rest {
    enabled    = true
    kms_key_id = data.terraform_remote_state.kms.outputs.key_arn
  }

  node_to_node_encryption {
    enabled = true
  }

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name     = local.creds.opensearch_username
      master_user_password = local.creds.opensearch_password
    }
  }

  snapshot_options {
    automated_snapshot_start_hour = 3
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  log_publishing_options {
    enabled                  = true
    log_type                 = "ES_APPLICATION_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.app_logs.arn
  }

  log_publishing_options {
    enabled                  = true
    log_type                 = "SEARCH_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.search_slow_logs.arn
  }

  log_publishing_options {
    enabled                  = true
    log_type                 = "INDEX_SLOW_LOGS"
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.index_slow_logs.arn
  }

  software_update_options {
    auto_software_update_enabled = var.opensearch_auto_software_update_enabled
  }

  auto_tune_options {
    desired_state       = var.auto_tune_enabled ? "ENABLED" : "DISABLED"
    rollback_on_disable = var.auto_tune_rollback_on_disable
    maintenance_schedule {
      start_at = var.maintenance_schedule.start_at
      duration {
        value = var.maintenance_schedule.duration_value
        unit  = var.maintenance_schedule.duration_unit
      }
      cron_expression_for_recurrence = var.maintenance_schedule.cron_expression_for_recurrence
    }
  }

  off_peak_window_options {
    enabled = var.off_peak_window_enabled
    off_peak_window {
      window_start_time {
        hours   = var.off_peak_window_hours
        minutes = var.off_peak_window_minutes
      }
    }
  }
}
