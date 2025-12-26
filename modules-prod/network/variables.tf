variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC-PROD"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet-PROD"
}

variable "availability_zone" {
  type        = string
}