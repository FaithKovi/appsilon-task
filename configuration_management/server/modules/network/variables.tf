variable "vpc_id" {
  description = "The ID of appsilon VPC"
  type        = string
  default     = null
}

variable "subnet_cidr_block" {
  description = "CIDR range of subnets in appsilon VPC"
  type        = string
  default     = null
}

variable "az" {
  description = "Availability zone to deploy into"
  type        = string
  default     = "us-east-1c"
}

variable "default_route_table_id" {
  description = "ID of default route table"
  type        = string
  default     = null
}