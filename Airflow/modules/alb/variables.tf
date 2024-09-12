variable "stage" {
    default = "dev"  
}

variable "project_name" {
    default = "airflow"  
}

variable "vpc" {
  type = string
}

variable "certificate_arn" {
  default = "arn:aws:acm:us-east-1:791167451670:certificate/74464c2d-fd4b-438f-be41-13b8f9a69cc7"
}

# variable "subnet_ids" {
#   default = ["subnet-0ebbfbbb19a889f58","subnet-02814ea333af7edf3"]
# }

variable "public_subnet_one" {
  type = string
}

variable "public_subnet_two" {
  type = string
}
