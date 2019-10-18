resource "aws_security_group" "sg_alb" {
  name        = "sg_alb_${var.application}"
  description = "Permite trafego para o balanceador de carga."
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.alb_port
    to_port     = var.alb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = var.ecs_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_lb" "alb" {
  name                             = var.application
  internal                         = true
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.sg_alb.id]
  subnets                          = data.aws_subnet_ids.private_subnet_ids.ids
  enable_cross_zone_load_balancing = true
  enable_http2                     = true

  tags = {
    Name        = var.ecs_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }

  access_logs {
    bucket  = aws_s3_bucket.s3_alb_logs.id
    enabled = true
  }

  depends_on = [
    aws_security_group.sg_alb,
    aws_s3_bucket_policy.s3_alb_logs,
  ]
}

resource "aws_lb_target_group" "alb_target_group" {
  name                 = var.application
  port                 = var.application_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  slow_start           = "30"
  deregistration_delay = "5"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = "5"
    enabled         = false
  }

  health_check {
    interval            = "30"
    path                = var.target_group_health_check_path
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    matcher             = "200"
  }

  tags = {
    Name        = var.ecs_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

