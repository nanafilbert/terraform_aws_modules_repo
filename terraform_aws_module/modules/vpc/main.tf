resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    { 
      Name = "${var.name}-vpc"
   },
    var.tags
  )
}




resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.name}-igw" },
    var.tags
  )
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    { Name = "${var.name}-public_subnet-${count.index + 1} ", Tier = "public" },
    var.tags
  )
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = merge(
    { Name = "${var.name}-private_subnet-${count.index + 1} ", Tier = "private" },
    var.tags
  )
}

# Elastic IP for NAT
resource "aws_eip" "nat_eip" {

  tags = {
    Name = "${var.name}-nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id  # NAT goes in first public subnet

  tags = merge({ Name = "${var.name}-nat-gateway" }, var.tags)

  depends_on = [aws_internet_gateway.igw]
}


# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({ Name = "${var.name}-public_rt" }, var.tags)
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = merge({ Name = "${var.name}-private_rt" }, var.tags)
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}


###