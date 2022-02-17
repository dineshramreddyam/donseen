# create securuty group
resource "aws_security_group" "lb-sg" {
  name        = "${var.app_name}-${terraform.workspace}-elb-sg"
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
    Name = "${var.app_name}-${terraform.workspace}-elb-sg"
  }
}



/*

locals {
  ports_in = [
    80
  ]
  ports_out = [
    0
  ]
}

resource "aws_security_group" "lb-sg" {
  name        = "lb_security"
  description = "allow_tls"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = toset(local.ports_in)
    content {
      description      = "HTTPS from VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = toset(local.ports_out)
    content {
      from_port        = egress.value
      to_port          = egress.value
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }
}
*/