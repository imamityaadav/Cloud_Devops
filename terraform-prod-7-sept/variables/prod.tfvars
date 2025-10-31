

backend_bucket = "gyan-bharatam-terrafrom-backend-bucket-prod"

backend_path = "prod"


customer_name = "gyan-bharatam"

account_id = "975373242096"

bucket_name = "gyan-bharatam-prod"

s3_tags = {environment = "uat", project = "gyan-bharatam"}

#######################VPC##########################

vpc_cidr = "10.84.0.0/16"

database_subnet_1_cidr = "10.84.200.0/24"

database_subnet_2_cidr = "10.84.201.0/24"

database_subnet_3_cidr = "10.84.202.0/24"

private_subnet_1_cidr = "10.84.0.0/19"

private_subnet_2_cidr = "10.84.32.0/19"

private_subnet_3_cidr = "10.84.64.0/19"

vpc_tags = {environment = "prod", project = "gyan-bharatam"}
##########################################################################
lb_tags = {environment = "UAT"}


eks_tags = {environment = "prod", project = "gyan-bharatam"}



jumpbox_tags = {environment = "UAT"}




environment = "prod"

region = "ap-south-1"

kms_key_name = "gyan-bharatam-prod-cmk"

kms_tags = {environment = "prod", project = "gyan-bharatam"}

cluster-name = "gyan-bharatam-prod"


cloudwatch_logs = false

cluster-autoscaler = false

ec2_root_volume_size = "20"

service_cidr = "172.20.0.0/16"

node_groups_test_tt = [
  {
    name           = "karpenter-nodegroup-prod"
    instance_types = ["m6a.large", "m5a.large"]
    ng_test_tags = {
      project: "gyan-bharatam"
    }
    labels = {
      prod = "true"
    }
    minimum_size   = 1
    maximum_size   = 6
    desired_size   = 1
    capacity_type  = "ON_DEMAND"
  }
]


###############EKS-ADDON##############################
coredns_version              = "v1.12.1-eksbuild.2"
kube_proxy_version           = "v1.33.0-eksbuild.2"
pod_identity_agent_version   = "v1.3.8-eksbuild.2"
ebs_csi_driver_version       = "v1.48.0-eksbuild.1"
efs_csi_driver_version       = "v2.1.10-eksbuild.1"
vpc_cni_version              = "v1.19.5-eksbuild.1"

###############EFS##################
efs_tags = {environment = "prod", project = "gyan-bharatam", Name = "gyan-bharatam-prod-efs"}
efs-security-group = "gyan-bharatam-efs-sg"

k8s_version = "1.33"

ami = "ami-0e639fddd264584f2"


ec2_key_name = "jumpbox-key-ec2"

ec2_instance_type = "t4g.small"


elasticsearch_user = "ec2-elasticsearch-user"
elasticsearch_ec2_instance_type = "t4g.small"
elasticsearch_ami = "ami-0fad8318b9405c6fb"
elasticsearch_tags = {environment = "UAT"}

gyan_bharatam_db_instance_identifier = "gyan-bharatam-prod"

gyan_bharatam_db_security_group = "gyan-bharatam-prod-sg"


major_version = "16"

gyan_bharatam_db_allocated_storage = "500"

engine_version = "16.10"

gyan_bharatam_db_instance_type = "db.m7g.xlarge"

gyan_bharatam_database_name = "gyan_bharatam_prod"

rds_secret_name = "psql"

rds_port = 5432

rds_multi_az = true

rds_tags  = {environment = "prod", project = "gyan-bharatam"}

js_user = "ec2-js-user"

eks_key_name = "eks-key"

##########################opensearch##########################

opensearch_secret_name = "opensearch"
domain_name                = "gyan-bharatam-prod"
opensearch_engine_version  = "OpenSearch_2.19"
ip_address_type            = "ipv4"
opensearch_instance_type   = "m7g.4xlarge.search"
opensearch_instance_count  = 3
dedicated_master_enabled   = true
master_instance_type       = "m7g.large.search"
master_instance_count      = 3
zone_awareness_enabled     = true
availability_zone_count    = 3
multi_az_with_standby_enabled = true

# Storage
opensearch_volume_size = 1000

# Logging
opensearch_log_retention_days = 90

# Access Policy
allowed_aws_account_ids = ["456815840094"]

# Software Updates
opensearch_auto_software_update_enabled = false

# Auto-Tune
auto_tune_enabled             = true
auto_tune_rollback_on_disable = "NO_ROLLBACK"

maintenance_schedule = {
  start_at                       = "2025-09-10T02:00:00Z" 
  duration_value                 = 2
  duration_unit                  = "HOURS"
  cron_expression_for_recurrence = "cron(0 2 ? * SUN *)"
}


# Off-Peak Window
off_peak_window_enabled = true
off_peak_window_hours   = 2
off_peak_window_minutes = 0

# Tags
opensearch_tags = {
  project     = "Gyan Bharatam"
  environment = "Production"
  owner       = "DevOps Team"
  costcenter  = "Engineering"
  backup      = "Required"
}


