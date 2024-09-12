output "alb_target_group" {
  value = aws_alb_target_group.airflow_web_server.id
}

output "alb_listener" {
  value = aws_alb_listener.airflow_web_server.id
}

output "web_server_ecs_internal" {
  value = aws_security_group.web_server_ecs_internal.id
}

output "scheduler_ecs_internal" {
  value = aws_security_group.scheduler.id
}

output "workers_ecs_internal" {
  value = aws_security_group.workers.id
}

output "flower_ecs_internal" {
  value = aws_security_group.flower.id
}