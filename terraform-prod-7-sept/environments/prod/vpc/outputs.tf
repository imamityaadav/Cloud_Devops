output "vpc_id" {
  value = module.vpc.vpc_id
}

output "database_subnet_ids" {
  value = module.vpc.database_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_route_table_id" {
  value = module.vpc.private_route_table_id
}

output "database_route_table_id" {
  value = module.vpc.database_route_table_id
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

