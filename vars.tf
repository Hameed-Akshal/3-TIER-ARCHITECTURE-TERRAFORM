variable "aws_region" {
  description = "AWS Region"
}

variable "amazon_linux_2023_ami" {
  description = "AMI for Amazon Linux 2023"
}

variable "wpsecurity_group_id" {
  description = "ID of the existing wordpress security group"
}

variable "dbsecurity_group_id" {
  description = "ID of the existing database security group"
}

variable "efs_security_group_id" {
  description = "ID of the existing efs security group"
}

variable "pub_a_subnet_id" {
  description = "ID of the existing subnet"
}
variable "db_a_subnet_id" {
  description = "ID of the db_a subnet"
}

variable "db_b_subnet_id" {
  description = "ID of the db_b subnet"
}

variable "db_c_subnet_id" {
  description = "ID of the db_c subnet"
}

variable "app_a_subnet_id" {
  description = "ID of the db_c subnet"
}

variable "app_b_subnet_id" {
  description = "ID of the db_c subnet"
}

variable "app_c_subnet_id" {
  description = "ID of the db_c subnet"
}

variable "aws_vpc_id" {
  description = "ID of the VPC"
  type        = string
}

