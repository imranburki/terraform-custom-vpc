output "vpc_id" {
  value = aws_vpc.main.id
}
output "internet_gateway" {
  value = aws_nat_gateway.net_gw.id
}