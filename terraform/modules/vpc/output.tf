
output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
}

output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}
