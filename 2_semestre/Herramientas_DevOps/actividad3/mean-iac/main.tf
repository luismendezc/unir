module "app" {
  source        = "./modules/ec2_app"
  subnet_id     = module.network.public_subnet_ids[0]
  sg_id         = module.sg.app_sg_id
  key_pair      = var.key_pair
  ami_id        = "ami-000014e8d990531ed"
  db_private_ip = module.db.private_ip
}

module "db" {
  source    = "./modules/ec2_db"
  subnet_id = module.network.private_subnet_id
  sg_id     = module.sg.db_sg_id
  key_pair  = var.key_pair
  ami_id    = "ami-000014e8d990531ed"
}

module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.network.vpc_id
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.network.vpc_id
  subnet_ids          = module.network.public_subnet_ids
  app_sg_id           = module.sg.app_sg_id
  target_instance_ids = [module.app.app_instance_id]
}
