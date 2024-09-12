variable "stage" {
    default = "dev"  
}

variable "project_name" {
    default = "airflow"  
}

# variable "subnet_ids" {
#   default = ["subnet-0ebbfbbb19a889f58","subnet-02814ea333af7edf3"]
# }

variable "metadata_db_instance_type" {
  default = "db.t4g.micro"
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

variable "vpc" {
  type = string
}

variable "public_subnet_one" {
  type = string
}

variable "public_subnet_two" {
  type = string
}
