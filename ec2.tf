provider "aws" {
  region = "us-east-1"  # Specify your desired AWS region
}

resource "aws_instance" "web" {
  ami           = "ami-0230bd60aa48260c6"                        #AMI
  instance_type = "t2.micro"                                     #instance_type
  vpc_security_group_ids = [aws_security_group.ec2scp.id]

  user_data = "${file("demo.sh")}"

  tags = {
    Name = "demoasdd"                                            #instance_name
  }
 }
  #Security Group Resource to open port 80 
  resource "aws_security_group" "ec2scp" {
  name        = "ec2scp"
  description = "Allow Inbound Traffic on Port 80"

  ingress {
    description      = "Port 80 from Everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 }

 output "public_ip" {
  value = aws_instance.web.public_ip
 }

  
