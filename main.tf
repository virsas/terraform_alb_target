provider "aws" {
  region = var.region
}

resource "aws_lb_target_group" "target" {
  target_type = "ip"

  name        = var.target.name
  port        = var.target.port
  protocol    = "HTTP"

  vpc_id      = var.vpc_id

  stickiness {
    type      = "lb_cookie"
  }

  health_check {
    path      = var.target.healthcheck
    port      = var.target.port
    matcher   = 200
  }
}

resource "aws_lb_target_group_attachment" "instances" {
  count            = length(var.instances)
  target_group_arn = aws_lb_target_group.target.arn
  target_id        = var.instances[count.index]
}