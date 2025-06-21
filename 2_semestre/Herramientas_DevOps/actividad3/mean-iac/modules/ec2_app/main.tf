variable "subnet_id" {}
variable "sg_id" {}
variable "key_pair" {}
variable "ami_id" {}
variable "db_private_ip" {}

resource "aws_instance" "app" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_pair
  user_data_replace_on_change = true
  user_data                   = templatefile("${path.module}/setup.sh.tpl", { db_private_ip = var.db_private_ip })
  tags = {
    Name = "mean-app"
  }
}
