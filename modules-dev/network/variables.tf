variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC-DEV"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet-DEV"
}

variable "availability_zone" {
  type        = string
}