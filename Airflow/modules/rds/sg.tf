resource "aws_security_group" "airflow_postgres_sg" {
  name = "${var.project_name}-${var.stage}-postgres-public-sg"
  description = "Allow all inbound for Postgres"
  vpc_id      = var.vpc

  ingress {
    description = "Inbound from ECS Webserver"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.web_server_ecs_internal]
  }

  ingress {
    description = "Inbound from ECS Scheduler"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.scheduler_ecs_internal]
  }
  
  ingress {
    description = "Inbound from ECS Worker"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.workers_ecs_internal]
  }

  ingress {
    description = "Inbound from ECS flower"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.flower_ecs_internal]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-postgres-public-sg"
  }
}

