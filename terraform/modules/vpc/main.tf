# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    "Name" = "${var.project}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-igw"
  }
}

# Default Route table -> public
resource "aws_route" "public" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.arn
}

# Public Subnet
resource "aws_subnet" "public" {
  count = length(data.aws_availability_zones.azs.names)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    "Name" = format(
      "${var.project}-pub-subnet-%s",
      substr(data.aws_availability_zones.azs.names[count.index], -1, 1),
    )
  }
}

# Public Subnet Route Table 연동
resource "aws_route_table_association" "public" {
  count = length(data.aws_availability_zones.azs.names)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route.public.id
}

# NAT 게이트웨이에 부여할 EIP
resource "aws_eip" "nat" {
  domain = "vpc"
}

# NAT 게이트웨이
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    "Name" = "${var.project}-nat-gw"
  }
}

# 프라이빗 서브넷
resource "aws_subnet" "private" {
  count = length(data.aws_availability_zones.azs.names)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    "Name" = format(
      "${var.project}-pri-subnet-%s",
      substr(data.aws_availability_zones.azs.names[count.index], -1, 1),
    )
  }
}

# 프라이빗 서브넷용 라우팅 테이블
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-pri-rtb"
  }
}

# 각각의 프라이빗 서브넷에 위에서 생성한 라우팅 테이블 연동
resource "aws_route_table_association" "private" {
  count = length(data.aws_availability_zones.azs.names)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# 프라이빗 서브넷에 연동된 라우팅 테이블에 NAT 게이트웨이로 가능 경로 추가
resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.this.id
  destination_cidr_block = "0.0.0.0/0"
}

# DB 서브넷
resource "aws_subnet" "db" {
  count = length(data.aws_availability_zones.azs.names)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 20)
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    "Name" = format(
      "${var.project}-db-subnet-%s",
      substr(data.aws_availability_zones.azs.names[count.index], -1, 1),
    )
  }
}

# DB 서브넷용 라우팅 테이블
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-db-rtb"
  }
}

# 각각의 DB 서브넷에 위에서 생성한 라우팅 테이블 연동
resource "aws_route_table_association" "db" {
  count = length(data.aws_availability_zones.azs.names)

  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}

# Intra 서브넷
resource "aws_subnet" "intra" {
  count = length(data.aws_availability_zones.azs.names)

  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 30)
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    "Name" = format(
      "${var.project}-intra-subnet-%s",
      substr(data.aws_availability_zones.azs.names[count.index], -1, 1),
    )
  }
}

# 인트라 서브넷용 라우팅 테이블
resource "aws_route_table" "intra" {
  vpc_id = aws_vpc.this.id

  tags = {
    "Name" = "${var.project}-intra-rtb"
  }
}

# 각각의 인트라 서브넷에 위에서 생성한 라우팅 테이블 연동
resource "aws_route_table_association" "intra" {
  count = length(data.aws_availability_zones.azs.names)

  subnet_id      = aws_subnet.intra[count.index].id
  route_table_id = aws_route_table.intra.id
}
