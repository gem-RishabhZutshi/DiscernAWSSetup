output "webserver_taskdef_arn" {
  value = aws_ecs_task_definition.airflow_webserver.arn
}

output "scheduler_taskdef_arn" {
  value = aws_ecs_task_definition.airflow_scheduler.arn
}

output "worker_taskdef_arn" {
    value = aws_ecs_task_definition.airflow_worker.arn  
}

output "flower_taskdef_arn" {
    value = aws_ecs_task_definition.airflow_flower.arn  
}