resource "aws_route53_record" "route53" {
  zone_id = aws_route53_zone.var.region.zone_id
  name    = "www.donseen.com"
  type    = "A"
  ttl     = "300"
  records = aws_elb.main.public_ip
}