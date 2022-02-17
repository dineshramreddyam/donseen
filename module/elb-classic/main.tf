resource "aws_elb" "main" {
  name               = "terr-elb"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = var.subnets

  dynamic "listener" {
      for_each = var.listners
      content {
    instance_port     = listener.value.instance_port
    instance_protocol = listener.value.instance_protocol
    lb_port           = listener.value.lb_port
    lb_protocol       = listener.value.lb_protocol
   }
  }

 health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    target              = var.target
    interval            = var.interval
  }

  instances                   =var.instances
  cross_zone_load_balancing   = var.cross_zone_load_balancing
  idle_timeout                = var.idle_timeout
  connection_draining         = var.connection_draining
  connection_draining_timeout = var.connection_draining_timeout

  tags = {
    Name = "${var.app_name}-${terraform.workspace}-elb"
  }
}