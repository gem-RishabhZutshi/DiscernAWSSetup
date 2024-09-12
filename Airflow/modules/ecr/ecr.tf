resource "aws_ecr_repository" "airflow_docker_repository" {
  name = "${var.project_name}-${var.stage}"
}

resource "aws_ecr_lifecycle_policy" "airflow_docker_repository_lifecycle_policy" {
  repository = aws_ecr_repository.airflow_docker_repository.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep only the latest 5 images",
            "selection": {
                "tagStatus": "any",
                "countType": "imageCountMoreThan",
                "countNumber": 5
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}


