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

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.terraform-instance.public_ip
}

output "grafana_url" {
  value = "http://${aws_instance.terraform-instance.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${aws_instance.terraform-instance.public_ip}:9090"
}

output "splunk_url" {
  value = "http://${aws_instance.terraform-instance.public_ip}:8000"
}

output "backend_metrics_url" {
  value = "http://${aws_instance.terraform-instance.public_ip}:5000/metrics"
}

output "alb_dns_name" {
  value = aws_lb.frontend_alb.dns_name
}