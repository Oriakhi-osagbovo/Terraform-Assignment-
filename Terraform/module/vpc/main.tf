resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "public" {
  count = var.azs
  vpc_id = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 2)
  availability_zone = var.azs[count.index]

  tags = {
    Name = "Public-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main Internet Gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route" "internet" {
  count = var.azs
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id

  tags = {
    Name = "Internet Route-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public" {
  count = var.azs
  subnet_id = aws_subnet.public.*.id
  route_table_id = aws_route_table.public.id
}
