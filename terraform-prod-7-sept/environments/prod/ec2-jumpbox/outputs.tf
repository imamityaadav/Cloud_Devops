

output "private_ip" {
  description = "Private IP of instance"
  value       = module.jumpbox.private_ip
}

output "private_dns" {
  description = "Private DNS of instance"
  value       = module.jumpbox.private_dns
}

output "id" {
  description = "Disambiguated ID of the instance"
  value       = module.jumpbox.id
}

output "arn" {
  description = "ARN of the instance"
  value       = module.jumpbox.arn
}

