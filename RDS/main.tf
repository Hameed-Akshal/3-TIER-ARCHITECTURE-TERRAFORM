resource "aws_db_subnet_group" "wordpress_rds_subnet_group" {
  name        = "wbrdssubnetgroup"
  description = "RDS Subnet Group for WordPress"
 # vpc_id      = var.aws_vpc_id
  subnet_ids = [
    var.db_a_subnet_id,
    var.db_b_subnet_id,
    var.db_c_subnet_id,
  ]
}

resource "aws_db_instance" "wordpress_rds_instance" {
  identifier           = "a4lwordpress"
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = "db.t2.micro"  # Choose appropriate instance class
  allocated_storage    = 20  # Size in GB
  storage_type         = "gp2"
  publicly_accessible  = false

  vpc_security_group_ids = [var.dbsecurity_group_id]  # Replace with your actual security group ID

  db_subnet_group_name  = aws_db_subnet_group.wordpress_rds_subnet_group.name
  multi_az              = false
  availability_zone     = "us-east-1a"
# initial_databse_name  = "a4lwordpressdb"
  username              = "a4lwordpressuser"
  password              = "4n1m4l54L1f3"
  skip_final_snapshot = true
}


