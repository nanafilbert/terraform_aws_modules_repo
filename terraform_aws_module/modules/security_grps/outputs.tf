output "alb_sg_id" {
  description = "ID of the Security Group"
  value       = aws_security_group.alb.id
}

output "app_sg_id" {
  description = "ID of the Application Security Group"
  value       = aws_security_group.app.id
  
}

output "db_sg_id" {
  description = "ID of the Database Security Group"
  value       = aws_security_group.db.id
  
}

