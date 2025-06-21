output "app_public_ip" { value = module.app.public_ip }
output "app_private_ip" { value = module.app.private_ip }
output "db_public_ip" { value = module.db.public_ip }
output "db_private_ip" { value = module.db.private_ip }
output "alb_dns_name" {
  value = module.alb.dns_name
}
output "nat_gateway_public_ip" {
  value = module.network.nat_gateway_eip
}
