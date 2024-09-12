variable "stage" {
    default = "dev"  
}

variable "project_name" {
    default = "airflow"  
}

variable "worker_service_name" {
    type = string
}

variable "log_group_name" {
  default = "ecs/fargate"
}