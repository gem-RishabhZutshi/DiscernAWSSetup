variable "stage" {
    default = "dev"  
}

variable "redis_url" {
    default = "dev"  
}

variable "ecs_task_execution_role" {
    type = string
    description = "The ARN of the IAM role to use for ECS task execution."
}

variable "project_name" {
    default = "airflow"  
}

variable "rds_host" {
  type = string
}