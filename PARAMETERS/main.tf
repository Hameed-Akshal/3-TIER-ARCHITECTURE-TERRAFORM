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
