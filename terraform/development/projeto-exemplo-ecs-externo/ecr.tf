resource "aws_ecr_repository" "ecr_repository" {
  name = var.ecr_name

  tags = {
    Name        = var.ecr_name
    Environment = var.environment
    Billing     = var.billing
    Application = var.application
    Provisioner = var.provisioner
  }

  provisioner "local-exec" {
    command     = "ansible-playbook --extra-vars 'project_name=${var.application} region=${var.region} aws_profile=${var.profile} git_repo=${var.git_repo} git_branch=${var.git_repo_branch} docker_tag=${var.docker_tag} ecr_repo=${aws_ecr_repository.ecr_repository.repository_url}' ./${var.application}.yml | tee ${var.application}.out"
    working_dir = "../../../ansible/"
  }
}

