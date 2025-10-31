output "opensearch_domain_name" {
  description = "OpenSearch domain name"
  value       = module.opensearch.opensearch_domain_name
}

output "opensearch_endpoint" {
  description = "OpenSearch domain endpoint"
  value       = module.opensearch.opensearch_endpoint
}


output "opensearch_sg_id" {
  description = "Security group ID for OpenSearch"
  value       = module.opensearch.opensearch_sg_id
}

