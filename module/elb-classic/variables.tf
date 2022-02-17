variable "app_name"{
    default = "my_app"
}

variable "vpc_id"{

}

variable "subnets"{

}

variable "listners"{
    type = map(object({
    instance_port     = number
    instance_protocol = string
    lb_port           = number
    lb_protocol       = string
    }))
 default={
    80 = {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
 }   
}

variable "health_check" {
    default = 2
}

variable "healthy_threshold" {
    default = 2
}

variable "unhealthy_threshold" {
    default = 2
}

variable "timeout" {
    default = 3
}

variable "target" {
    default = "HTTP:80/"
}

variable "interval" {
    default = 30
}

variable "instances" {
    default = null
}

variable "cross_zone_load_balancing" {
    default = true
}

variable "idle_timeout" {
    default = 400
}

variable "connection_draining" {
    default = true
}

variable "connection_draining_timeout" {
    default = 400
}