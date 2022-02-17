resource "aws_security_group" "web-sg" {
  name        = "${var.app_name}-${terraform.workspace}-ec2-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

 ingress  {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

 egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-ec2-sg"
  }
}