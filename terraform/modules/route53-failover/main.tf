resource "aws_route53_health_check" "primary" {
  fqdn              = var.primary_lb_dns
  port              = 80
  type              = "HTTP"
  resource_path     = "/health"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_route53_record" "primary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "CNAME"
  ttl     = 60
  records = [var.primary_lb_dns]

  set_identifier  = "primary"
  failover_routing_policy {
    type = "PRIMARY"
  }
  health_check_id = aws_route53_health_check.primary.id
}

resource "aws_route53_record" "secondary" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "CNAME"
  ttl     = 60
  records = [var.secondary_lb_dns]

  set_identifier = "secondary"
  failover_routing_policy {
    type = "SECONDARY"
  }
}
