resource "aws_instance" "web01" {
  ami           = "ami-0a23ccb2cdd9286bb" # ap_south-1
  instance_type = "t2.micro"
  subnet_id = var.subnet[1]  
  associate_public_ip_address = true
  user_data = "${file("user_data.sh")}"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  tags = {
    Name = "ec2-instance-${terraform.workspace}"
     } 
  }