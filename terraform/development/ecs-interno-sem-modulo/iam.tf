resource "aws_iam_role" "role" {
  name = "${var.application}-role"

  assume_role_policy = <<-JSON
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
JSON


  tags = {
    Environment = var.environment
    Billing = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  role = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

