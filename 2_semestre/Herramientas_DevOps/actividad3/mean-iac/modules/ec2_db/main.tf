variable "subnet_id" {}
variable "sg_id" {}
variable "key_pair" {}
variable "ami_id" {}

resource "aws_instance" "db" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_pair
  user_data_replace_on_change = true
  user_data                   = file("${path.module}/setup_mongo.sh")
  tags = {
    Name = "mean-db"
  }
}
