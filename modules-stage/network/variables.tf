variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC-STAGE"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet-STAGE"
}

variable "availability_zone" {
  type        = string
}