resource "aws_ecs_service" "web_server_service" {
  name                               = "${var.project_name}-${var.stage}-web-server"
  cluster                            = var.ecs_cluster
  task_definition                    = var.webserver_taskdef_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups  = [var.web_server_ecs_internal]
    subnets          = [var.public_subnet_one, var.public_subnet_two]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.alb_target_group
    container_name   = "airflow_web_server"
    container_port   = 8080
  }

  depends_on = [
  var.rds_instance,
  var.alb_listener,
  ]
}

resource "aws_ecs_service" "scheduler_service" {
  name                               = "${var.project_name}-${var.stage}-scheduler"
  cluster                            = var.ecs_cluster
  task_definition                    = var.scheduler_taskdef_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups  = [var.scheduler_ecs_internal]
    subnets          = [var.public_subnet_one, var.public_subnet_two]
    assign_public_ip = true
  }

  depends_on = [
  var.rds_instance,
  ]
}

resource "aws_ecs_service" "worker_service" {
  name                               = "${var.project_name}-${var.stage}-worker"
  cluster                            = var.ecs_cluster
  task_definition                    = var.worker_taskdef_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups  = [var.workers_ecs_internal]
    subnets          = [var.public_subnet_one, var.public_subnet_two]
    assign_public_ip = true
  }

  depends_on = [
  var.rds_instance,
  ]
}

resource "aws_ecs_service" "flower_service" {
  name                               = "${var.project_name}-${var.stage}-flower"
  cluster                            = var.ecs_cluster
  task_definition                    = var.flower_taskdef_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 60

  network_configuration {
    security_groups  = [var.flower_ecs_internal]
    subnets          = [var.public_subnet_one, var.public_subnet_two]
    assign_public_ip = true
  }

  depends_on = [
  var.rds_instance,
  ]
}

