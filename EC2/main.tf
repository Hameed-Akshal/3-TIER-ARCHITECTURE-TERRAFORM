# IAM Role
resource "aws_iam_role" "wordpress_role" {
  name               = "WPRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  path = "/"

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess",
    # Add more managed policies if needed
  ]
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "wordpress_instance_profile" {
  name = "WordpressInstanceProfile"
  path = "/"

  role = aws_iam_role.wordpress_role.name
}

#resource "aws_instance" "web" {
#  ami                    = "ami-0230bd60aa48260c6"
#  instance_type          = "t2.micro"

 # key_name               = "akshal1.pem"

#  vpc_security_group_ids = ["sg-0babac8ae6c131880"]
#  subnet_id              = "subnet-0ccc8d427e5ab3c0f"
 # user_data = "${file("setup.sh")}"

#  associate_public_ip_address = true

#  iam_instance_profile    = aws_iam_instance_profile.wordpress_instance_profile.name

#  credit_specification {
#    cpu_credits = "standard"
#     }

#  tags = {
#    Name = "ak"                                            #instance_name
#  }
#}




# Create Launch Template
resource "aws_launch_template" "wordpress_launch_template" {
  name          = "Wordpress"
#  version_description = "Single server DB and App"

  image_id      = "ami-0230bd60aa48260c6"  # Replace with the actual Amazon Linux 2023 AMI
  instance_type = "t2.micro"  # or "t2.micro" or any other instance type
  vpc_security_group_ids = ["sg-0babac8ae6c131880"]

  

  iam_instance_profile {
    name = aws_iam_instance_profile.wordpress_instance_profile.name
  }

  credit_specification {
    cpu_credits = "standard"
  }
  user_data = base64encode(file("./EC2/setup.sh"))

#  output "launch_template_id" {
#  value = aws_launch_template.wordpress_launch_template.id
#  }
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity     = 1  # Adjust as needed
  max_size             = 1  # Adjust as needed
  min_size             = 1  # Adjust as needed
  vpc_zone_identifier  = ["subnet-0ccc8d427e5ab3c0f"]  # Replace with your subnet ID
  launch_template {
    id      = aws_launch_template.wordpress_launch_template.id
    version = "$Latest"
  }
}