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

#  key_name               = "akshal1.pem"

#  vpc_security_group_ids = ["sg-0babac8ae6c131880"]
#  subnet_id              = "subnet-0ccc8d427e5ab3c0f"
#  user_data = "${file("setup.sh")}"

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
  image_id      = "ami-0230bd60aa48260c6"  # Replace with the actual Amazon Linux 2023 AMI
  instance_type = "t2.micro"  # or "t2.micro" or any other instance type
  vpc_security_group_ids = ["sg-0d502a492a7555e37"]
  iam_instance_profile {
    name = aws_iam_instance_profile.wordpress_instance_profile.name
  }
  credit_specification {
    cpu_credits = "standard"
  }
  user_data = base64encode(file("./EC2/setup.sh"))
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "wordpress_asg" {
  desired_capacity     = 1  # Adjust as needed
  max_size             = 1  # Adjust as needed
  min_size             = 1  # Adjust as needed
  #vpc_zone_identifier  = ["subnet-01072fb42118fb768"]
  vpc_zone_identifier  = ["subnet-01072fb42118fb768","subnet-0d398bda21d293afa","subnet-06df6276e836c7dc6"]  # Replace with your subnet ID
  launch_template {
    id      = aws_launch_template.wordpress_launch_template.id
    version = "$Latest"
  }
  health_check_type          = "ELB"
  health_check_grace_period  = 300
  force_delete                = true
  protect_from_scale_in      = false
  tag {
    key                 = "Name"
    value               = "WordPressASG"
    propagate_at_launch = true
  }
}

resource "aws_lb" "wordpress_alb" {
  name               = "A4LWORDPRESSALB"
  internal           = false
  load_balancer_type = "application"
  enable_deletion_protection = false

  subnets = [
    "subnet-01072fb42118fb768",
    "subnet-0d398bda21d293afa",
    "subnet-06df6276e836c7dc6"
  ]

  security_groups = ["sg-027f8271fd932f066"]

  enable_http2             = true
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_target_group" "wordpress_alb_target_group" {
  name        = "A4LWORDPRESSALBTG"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-0a0133cfdf4e37ce5"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

resource "aws_lb_listener" "wordpress_listener" {
  load_balancer_arn = aws_lb.wordpress_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.wordpress_alb_target_group.arn
 #   weight           = 100
    
  }
}

resource "aws_lb_listener_rule" "wordpress_listener_rule" {
  listener_arn = aws_lb_listener.wordpress_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_alb_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}

#resource "aws_lb_target_group_attachment" "wordpress_tg_attachment" {
#  target_group_arn = aws_lb_target_group.wordpress_alb_target_group.arn
#  autoscaling_group_name        = aws_autoscaling_group.wordpress_asg.id
#}

resource "aws_autoscaling_attachment" "wordpress_tg_attachmen" {
  autoscaling_group_name = aws_autoscaling_group.wordpress_asg.id
  lb_target_group_arn    = aws_lb_target_group.wordpress_alb_target_group.arn
}