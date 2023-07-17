variable "vpc_cidr_block" {
  description = "IPv4 CIDR range of VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "IPv4 CIDR range of Subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "az" {
  description = "availablity zone of subnet"
  type        = string
}

variable "allowed_address_range" {
  description = "allowed IP to access remote node on port 22 (computer network IPv4  range see here: https://www.whatismyip.com/)"
  type        = string
  default     = "192.168.0.0/24"
}