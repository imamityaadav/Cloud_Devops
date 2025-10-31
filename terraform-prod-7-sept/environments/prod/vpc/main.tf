module "vpc" {
  source                     = "../../../modules/vpc"
  vpc_cidr                   = var.vpc_cidr
  database_subnet_1_cidr     = var.database_subnet_1_cidr
  database_subnet_2_cidr     = var.database_subnet_2_cidr
  database_subnet_3_cidr     = var.database_subnet_3_cidr
  private_subnet_1_cidr      = var.private_subnet_1_cidr
  private_subnet_2_cidr      = var.private_subnet_2_cidr
  private_subnet_3_cidr      = var.private_subnet_3_cidr
  vpc_tags                   = var.vpc_tags
  environment                = var.environment
  customer_name              = var.customer_name
}
