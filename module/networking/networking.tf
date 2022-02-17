# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "myapp-${terraform.workspace}"
    environement = terraform.workspace
      }
}

# create a public subnet
resource "aws_subnet" "public" {
  count = length(local.az_names)
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,4,count.index)
  availability_zone = local.az_names[count.index]
  tags={
    "Name"= "public_subnet-${count.index}"
  }
}

# create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  }

# create public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.gw.id
    }

  tags = {
    Name = "public-${terraform.workspace}"
  }
}

# associate public subnet to public route table
resource "aws_route_table_association" "public" {
  count = length(local.az_names)
  subnet_id      = local.pub_sub_ids[count.index]
  route_table_id = aws_route_table.public.id
}

# create private Subnets
resource "aws_subnet" "private" {
  count = length(local.az_names)
        = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr,4,count.index + length(data.aws_availability_zones.azs.names))
   availability_zone = local.az_names[count.index]
  tags={
    "Name"= "private_subnet-${count.index}"
  }
}

# create NAT Instance
resource "aws_instance" "nat" {
  ami           = "ami-0a23ccb2cdd9286bb"
  instance_type = "t2.micro"
  subnet_id = local.pub_sub_ids[0]
  associate_public_ip_address = true
  source_dest_check = false
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  tags = {
    Name = "nat-instance-${terraform.workspace}"
  }
}

# create private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block = "0.0.0.0/0"
      instance_id = aws_instance.nat.id
    }

  tags = {
    Name = "private-${terraform.workspace}"
  }
}

# associate private subnet to private route table
resource "aws_route_table_association" "private" {
  count = length(local.az_names)
  subnet_id      = local.pri_sub_ids[count.index]
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "web-sg" {
  name        ="nett_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

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
    Name = "nett_sg"
  }
}
