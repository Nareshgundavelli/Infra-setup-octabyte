output "aws_instance_public_ip" {
  value = aws_instance.terraform-instance.public_ip
  
}
output "aws_instance_private_ip" {
  value = aws_instance.terraform-instance.private_ip
}
output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "rds_port" {
  value = aws_db_instance.postgres.port
}

output "alb_dns_name" {
  value = aws_lb.frontend_alb.dns_name
}