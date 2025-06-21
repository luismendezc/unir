output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
}
output "nat_gateway_eip" {
  value = aws_eip.nat.public_ip
}
output "private_subnet_id" {
  value = aws_subnet.private_a.id
}
