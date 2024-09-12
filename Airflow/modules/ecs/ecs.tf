resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.project_name}-${var.stage}"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.log_group_name}/${var.project_name}-${var.stage}"
  retention_in_days = 365
}

resource "aws_appautoscaling_target" "worker_autoscaling_target" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/${aws_ecs_cluster.ecs_cluster.name}/${var.worker_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "scale-down"
  policy_type        = "StepScaling"
  resource_id        = aws_appautoscaling_target.worker_autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.worker_autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.worker_autoscaling_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
