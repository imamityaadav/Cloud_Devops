variable "customer_name" {
  description = "The name of the cluster"
  type        = string
}

variable "efs-security-group" {
  description = "The name of efs sg"
  type        = string
}

variable "region" {
  type = string
}

variable "backend_bucket" {
  type = string
}

variable "efs_tags" {
  type = map(string)
}

 variable "backend_path" {
  description = "The name of the cluster"
  type        = string
}

variable "environment" {
  type = string
  description = "environment name"
}
