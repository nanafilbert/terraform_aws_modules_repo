
output "filbert_output" {
  description = "The IDs of the EC2 instances"
  value       = { for k, inst in aws_instance.webserver : k => inst.id }
}


output "webserver_public_ip" {
  description = "The public IP addresses of the web servers"
  value       = [for inst in aws_instance.webserver : inst.public_ip]
}