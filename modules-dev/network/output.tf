output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id_DEV" {
  value = aws_subnet.public.id
}
