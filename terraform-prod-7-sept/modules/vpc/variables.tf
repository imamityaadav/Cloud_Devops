variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "database_subnet_1_cidr" {
  description = "CIDR block for the first database subnet"
  type        = string
}

variable "database_subnet_2_cidr" {
  description = "CIDR block for the second database subnet"
  type        = string
}

variable "database_subnet_3_cidr" {
  description = "CIDR block for the third database subnet"
  type        = string
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "private_subnet_3_cidr" {
  description = "CIDR block for the third private subnet"
  type        = string
}


variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
}

variable "environment" {
  type        = string
  description = "Environment for vpc"
}

variable "customer_name" {
  description = "Enter name of the customer"
  type        = string
}