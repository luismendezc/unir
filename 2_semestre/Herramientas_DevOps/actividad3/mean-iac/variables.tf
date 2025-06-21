variable "aws_region" { default = "us-west-1" }
variable "key_pair" {
  default     = "mean-key"
  description = "SSH key pair for EC2 instances"
}
variable "project_name" { default = "mean-demo" }
