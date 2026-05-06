aws_region = "ap-south-1"

vpc_cidr = "10.0.0.0/20"
vpc_name = "octabyte-vpc"

aws_internet_gateway = "octabyte-igw"

availability_zones   = ["ap-south-1a", "ap-south-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]

private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

private_route_table_name = "private-route"
public_route_table_name= "public-route"

instance_type = "t2.medium"
instance_name = "octa-pub"
key_name = "octa-correct-key"
ami ="ami-05e2a86d8dfbc265b"

db_instance_class = "db.r5.xlarge"
db_name = "octabytedb"
db_username = "octaadmin"   
db_password = "Octabyte123"
db_storage_size = 40

alb_name         = "octa-alb"
target_group_name = "octa-tg"