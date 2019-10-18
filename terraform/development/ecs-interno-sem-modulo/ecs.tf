resource "aws_security_group" "sg_ecs" {
  name        = "sg_ecs_${var.application}"
  description = "Permite trafego para os containers."
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.application_port
    to_port         = var.application_port
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_alb.id]
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

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_name

  tags = {
    Name        = var.ecs_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_ecs_task_definition" "ecs_task_definition" {
  family = var.application

  container_definitions = <<-JSON
  [
      {
        "dnsSearchDomains": null,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/${var.application}",
            "awslogs-region": "${var.region}",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "entryPoint": null,
        "portMappings": [
          {
            "hostPort": ${var.application_port},
            "protocol": "tcp",
            "containerPort": ${var.application_port}
          }
        ],
        "command": null,
        "linuxParameters": null,
        "cpu": 0,
        "environment": [],
        "resourceRequirements": null,
        "ulimits": null,
        "dnsServers": null,
        "mountPoints": [],
        "workingDirectory": null,
        "secrets": null,
        "dockerSecurityOptions": null,
        "memory": null,
        "memoryReservation": null,
        "volumesFrom": [],
        "image": "${var.ecr_uri}/${var.ecr_name}:latest",
        "disableNetworking": null,
        "interactive": null,
        "healthCheck": null,
        "essential": true,
        "links": null,
        "hostname": null,
        "extraHosts": null,
        "pseudoTerminal": null,
        "user": null,
        "readonlyRootFilesystem": null,
        "dockerLabels": null,
        "systemControls": null,
        "privileged": null,
        "name": "${var.application}"
      }
  ]
JSON


  task_role_arn = aws_iam_role.role.arn
  execution_role_arn = aws_iam_role.role.arn
  network_mode = "awsvpc"
  cpu = var.container_cpu
  memory = var.container_memory
  requires_compatibilities = ["FARGATE"]

  tags = {
    Name = var.ecs_name
    Environment = var.environment
    Billing = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_ecs_service" "ecs_service" {
  name = var.application
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count = var.container_desired_count
  launch_type = "FARGATE"
  platform_version = "LATEST"
  scheduling_strategy = "REPLICA"
  cluster = aws_ecs_cluster.ecs_cluster.id

  deployment_maximum_percent = "200"
  deployment_minimum_healthy_percent = "100"
  health_check_grace_period_seconds = "10"

  depends_on = [
    aws_iam_role.role,
    aws_security_group.sg_ecs,
    aws_ecr_repository.ecr_repository,
    aws_lb_listener.alb_listener,
    aws_cloudwatch_log_group.cloudwatch_log_group,
  ]

  load_balancer {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    container_name = var.application
    container_port = var.application_port
  }

  network_configuration {
    subnets = data.aws_subnet_ids.private_subnet_ids.ids
    security_groups = [aws_security_group.sg_ecs.id]
    assign_public_ip = "false"
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = {
    Name = var.ecs_name
    Environment = var.environment
    Billing = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

