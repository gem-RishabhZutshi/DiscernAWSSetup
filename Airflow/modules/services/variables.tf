variable "stage" {
    default = "dev"  
}

variable "project_name" {
    default = "airflow"  
}

variable "webserver_taskdef_arn" {
    type = string    
}

variable "scheduler_taskdef_arn" {
    type = string
}

variable "flower_taskdef_arn" {
    type = string
}

variable "worker_taskdef_arn" {
    type = string
}

variable "ecs_cluster" {
  type = string
}

# variable "subnet_ids" {
#   default = ["subnet-0ebbfbbb19a889f58","subnet-02814ea333af7edf3"]
# }

variable "alb_target_group" {
  type = string
}

variable "alb_listener" {
  type = string
}

variable "web_server_ecs_internal" {
  type = string
}

variable "scheduler_ecs_internal" {
  type = string
}

variable "workers_ecs_internal" {
  type = string
}

variable "flower_ecs_internal" {
  type = string
}

variable "public_subnet_one" {
  type = string
}

variable "public_subnet_two" {
  type = string
}

variable "rds_instance" {
  type = string
}