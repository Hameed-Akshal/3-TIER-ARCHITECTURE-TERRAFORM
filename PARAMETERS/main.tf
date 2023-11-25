resource "aws_ssm_parameter" "db_user" {
  name        = "/A4L/Wordpress/DBUser"
  description = "Wordpress Database User"
  type        = "String"
  value       = "a4lwordpressuser"
}

resource "aws_ssm_parameter" "db_name" {
  name        = "/A4L/Wordpress/DBName"
  description = "Wordpress Database Name"
  type        = "String"
  value       = "a4lwordpressdba"
}

resource "aws_ssm_parameter" "db_endpoint" {
  name        = "/A4L/Wordpress/DBEndpoint"
  description = "Wordpress Endpoint Name"
  type        = "String"
  value       = "localhost"
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/A4L/Wordpress/DBPassword"
  description = "Wordpress DB Password"
  type        = "SecureString"
  value       = "4n1m4l54L1f3"
}

resource "aws_ssm_parameter" "db_root_password" {
  name        = "/A4L/Wordpress/DBRootPassword"
  description = "Wordpress DBRoot Password"
  type        = "SecureString"
  value       = "4n1m4l54L1f3"
}

resource "aws_ssm_parameter" "wordpress_efs_fsid" {
  name        = "/A4L/Wordpress/EFSFSID"
  description = "File System ID for Wordpress Content (wp-content)"
  type        = "String"
  value       = "fs-0fd6cd1494840a8fa.efs.us-east-1.amazonaws.com"
  tier        = "Standard"
}

resource "aws_ssm_parameter" "wordpress_alb_dns" {
  name        = "/A4L/Wordpress/ALBDNSNAME"
  description = "DNS Name of the Application Load Balancer for wordpress"
  type        = "String"
  value       = "A4LWORDPRESSALB-371814060.us-east-1.elb.amazonaws.com"
  tier        = "Standard"
}
