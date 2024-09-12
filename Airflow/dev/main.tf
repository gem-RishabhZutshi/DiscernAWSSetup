# Call the IAM module
module "iam" {
  source = "../modules/iam"
}

# Call the ECS Task Definition module and pass the output from the IAM module
module "taskdefinations" {
  source = "../modules/taskdefinations"
  
  # Pass the IAM role ARN to ECS task definition
  ecs_task_execution_role = module.iam.ecs_task_execution_role
  # Pass the RDS Host Url to ECS task definition
  rds_host = module.rds.rds_host
}

module "ecs" {
    source = "../modules/ecs" 
    worker_service_name = module.services.worker_service_name 
}

module "ecr" {
  source = "../modules/ecr"
}

module "vpc" {
  source = "../modules/vpc"
}

module "alb" {
  source = "../modules/alb"
  vpc = module.vpc.vpc
  public_subnet_one = module.vpc.public_subnet_one
  public_subnet_two = module.vpc.public_subnet_two
}

module "rds" {
  source = "../modules/rds"
  web_server_ecs_internal = module.alb.web_server_ecs_internal
  scheduler_ecs_internal = module.alb.scheduler_ecs_internal
  workers_ecs_internal = module.alb.workers_ecs_internal
  flower_ecs_internal = module.alb.flower_ecs_internal
  vpc = module.vpc.vpc
  public_subnet_one = module.vpc.public_subnet_one
  public_subnet_two = module.vpc.public_subnet_two  
}

module "services" {
  source = "../modules/services"
  webserver_taskdef_arn = module.taskdefinations.webserver_taskdef_arn
  scheduler_taskdef_arn = module.taskdefinations.scheduler_taskdef_arn
  worker_taskdef_arn =  module.taskdefinations.worker_taskdef_arn
  flower_taskdef_arn = module.taskdefinations.flower_taskdef_arn
  ecs_cluster = module.ecs.ecs_cluster
  alb_target_group = module.alb.alb_target_group
  alb_listener = module.alb.alb_listener
  web_server_ecs_internal = module.alb.web_server_ecs_internal
  scheduler_ecs_internal = module.alb.scheduler_ecs_internal
  workers_ecs_internal = module.alb.workers_ecs_internal
  flower_ecs_internal = module.alb.flower_ecs_internal
  public_subnet_one = module.vpc.public_subnet_one
  public_subnet_two = module.vpc.public_subnet_two 
  rds_instance = module.rds.rds_instance
}




