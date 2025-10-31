output "vpc_id" {
  value = aws_vpc.main.id
}

output "database_subnet_ids" {
  value = [
    aws_subnet.database_1.id,
    aws_subnet.database_2.id,
    aws_subnet.database_3.id
  ]
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id,
    aws_subnet.private_3.id
  ]
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "database_route_table_id" {
  value = aws_route_table.database.id
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}
