resource "aws_subnet" "appsilon-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.az
  tags = {
    Name = "appsilon-subnet"
  }
}

resource "aws_internet_gateway" "appsilon-internet-gateway" {
  vpc_id = var.vpc_id

  tags = {
    Name = "appsilon-vpc-igw"
  }
}

resource "aws_default_route_table" "appsilon-default-route-table" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.appsilon-internet-gateway.id
  }

  tags = {
    Name = "appsilon-vpc-default-rtb"
  }
}