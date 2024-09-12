resource "aws_ecs_task_definition" "airflow_scheduler" {
  family                   = "${var.project_name}-${var.stage}-scheduler"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = var.ecs_task_execution_role
  container_definitions = <<EOF
  [
    {
      "name": "airflow-scheduler",
      "image": "apache/airflow:2.5.0",
      "essential": true,
      ],
      "command": [
        "scheduler"
      ],
      "environment": [
        {
            "name": "POSTGRES_HOST",
            "value": "${var.rds_host}"
        },
        {
            "name": "POSTGRES_PORT",
            "value": "5432"
        },
        {
            "name": "POSTGRES_USER",
            "value": "airflow"
        },
        {
            "name": "POSTGRES_PASSWORD",
            "value": "Airflow2021"
        },
        {
            "name": "POSTGRES_DB",
            "value": "airflow"
        },
        {
            "name": "FERNET_KEY",
            "value": "k8IfvPBpKOoDZSBbqHOQCgJkhXU_Y2wjwLZbJmavcXQ="
        },
        {
            "name": "AIRFLOW_BASE_URL",
            "value": "http://localhost:8080"
        },
        {
            "name": "ENABLE_REMOTE_LOGGING",
            "value": "False"
        },
        {
            "name": "STAGE",
            "value": "${var.stage}"
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/airflow-scheduler",
          "awslogs-region": "us-west-2",
          "awslogs-stream-prefix": "ecs"
        }
      },
    }
  ]
  EOF
}
