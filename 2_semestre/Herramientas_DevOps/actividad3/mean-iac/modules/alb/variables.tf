variable "vpc_id" {}
variable "subnet_ids" { type = list(string) }
variable "app_sg_id" {}
variable "target_instance_ids" { type = list(string) }
