variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/20"
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "octa-vpc"
}

variable "aws_internet_gateway" {
  description = "Name for the Internet Gateway" 
  type        = string
  default     = "octs-igw"
  
}


variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}


variable "public_route_table_name" {
  description = "Name for the public route table"
  type        = string
  default     = "octs-public-rt"
  
}

variable "private_route_table_name" {
  description = "Name for the private route table"
  type        = string
  default     = "octs-private-rt"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "value"
  
}


variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "value"
}
variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "value"
}

variable "instance_name" {
  type = string
  default = "octa-instance"
}
variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_instance_class" {
  type = string
  default = "db.t3.micro"
}
variable "db_storage_size" {
  type = number
  default = 20
  
}

variable "alb_name" {
  type = string
}

variable "target_group_name" {
  type = string
}