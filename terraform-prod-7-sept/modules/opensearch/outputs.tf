output "opensearch_domain_name" {
  description = "OpenSearch domain name"
  value       = aws_opensearch_domain.main.domain_name
}

output "opensearch_endpoint" {
  description = "OpenSearch domain endpoint"
  value       = aws_opensearch_domain.main.endpoint
}

output "opensearch_sg_id" {
  description = "Security group ID for OpenSearch"
  value       = aws_security_group.opensearch_sg.id
}

