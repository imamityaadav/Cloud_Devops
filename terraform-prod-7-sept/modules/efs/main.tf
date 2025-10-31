data "terraform_remote_state" "vpc_state" {
  backend = "s3"

  config = {
    bucket   = var.backend_bucket
    key      = "${var.backend_path}/backend/vpc"
    region   = var.region
    #role_arn   = var.role_arn
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"

  config = {
    bucket   = var.backend_bucket
    key      = "${var.backend_path}/backend/kms"
    region   = var.region
    #role_arn   = var.role_arn
  }
}


resource "aws_security_group" "efs_mount_target_sg" {
  name_prefix = var.efs-security-group
  vpc_id      = data.terraform_remote_state.vpc_state.outputs.vpc_id

  // Define ingress and egress rules as needed
  ingress {
    description = "Allow NFS traffic from EFS mount targets"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }


  egress {
    description = "Allowing all trafffic from VPC cidr"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.terraform_remote_state.vpc_state.outputs.vpc_cidr_block]
  }
    

  // Add more ingress or egress rules as needed
}

resource "aws_efs_file_system" "my_efs" {
  creation_token   = "${var.customer_name}-${var.environment}-efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "elastic"
  encrypted        = true
  kms_key_id = data.terraform_remote_state.kms.outputs.key_arn
  tags = var.efs_tags
}

resource "aws_efs_mount_target" "my_mount_target" {
  count           = length(data.terraform_remote_state.vpc_state.outputs.private_subnet_ids)
  file_system_id  = aws_efs_file_system.my_efs.id
  subnet_id       = element(data.terraform_remote_state.vpc_state.outputs.private_subnet_ids, count.index)
  security_groups = [aws_security_group.efs_mount_target_sg.id]
}

