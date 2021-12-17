output "url" {
  value       = "https://${module.compute.record}"
  description = "DNS address to access the application"
}