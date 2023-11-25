resource "aws_efs_file_system" "wordpress_content" {
  creation_token = "A4L-WORDPRESS-CONTENT"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted       = false  # Set to true for production use

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name = "A4L-WORDPRESS-CONTENT"
  }
}

resource "aws_efs_mount_target" "efs_mount_target_a" {
  file_system_id = aws_efs_file_system.wordpress_content.id
  #availability_zone_name = "us-east-1a"
  subnet_id      = "subnet-0023abcadf74473ec"
  security_groups = ["sg-0022f8cc47a56d542"]
}

resource "aws_efs_mount_target" "efs_mount_target_b" {
  file_system_id = aws_efs_file_system.wordpress_content.id
  #availability_zone_name = "us-east-1b"
  subnet_id      = "subnet-0ef7f3c3c2fa22f79"
  security_groups = ["sg-0022f8cc47a56d542"]
}

resource "aws_efs_mount_target" "efs_mount_target_c" {
  file_system_id = aws_efs_file_system.wordpress_content.id
  #availability_zone_name = "us-east-1c"
  subnet_id      = "subnet-0d59c4b8ce3fbcbe2"
  security_groups = ["sg-0022f8cc47a56d542"]
}