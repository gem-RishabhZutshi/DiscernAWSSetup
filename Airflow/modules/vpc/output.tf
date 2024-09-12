output "vpc" {
  value = aws_vpc.discern_dev_vpc.id
}

output "public_subnet_one" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet_two" {
  value = aws_subnet.public_subnet2.id
}