data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  constant_vpc_tags = {
    Name        = "${var.customer_name}-${var.environment}-vpc"
    ManagedBy   = "Terraform"
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    local.constant_vpc_tags,
    var.vpc_tags
  )
}


resource "aws_subnet" "database_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-database-subnet-1-${data.aws_availability_zones.available.names[0]}"
  })
}

resource "aws_subnet" "database_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-database-subnet-2-${data.aws_availability_zones.available.names[1]}"
  })
}

resource "aws_subnet" "database_3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.database_subnet_3_cidr
  availability_zone       = data.aws_availability_zones.available.names[2]
  map_public_ip_on_launch = false

  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-pubdatabaselic-subnet-3-${data.aws_availability_zones.available.names[2]}"
  })
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-private-subnet-1-${data.aws_availability_zones.available.names[0]}"
  })
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-private-subnet-2-${data.aws_availability_zones.available.names[1]}"
  })
}

resource "aws_subnet" "private_3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_3_cidr
  availability_zone = data.aws_availability_zones.available.names[2]

  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-private-subnet-2-${data.aws_availability_zones.available.names[2]}"
  })
}


resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = "${var.customer_name}-${var.environment}-database-route-table"
    environment = var.environment
  }
}


resource "aws_route_table_association" "database_subnet_1_assoc" {
  subnet_id      = aws_subnet.database_1.id
  route_table_id = aws_route_table.database.id
}

resource "aws_route_table_association" "database_subnet_2_assoc" {
  subnet_id      = aws_subnet.database_2.id
  route_table_id = aws_route_table.database.id
}

resource "aws_route_table_association" "database_subnet_3_assoc" {
  subnet_id      = aws_subnet.database_3.id
  route_table_id = aws_route_table.database.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.vpc_tags, {
    "Name" = "${var.customer_name}-${var.environment}-private-route-table"
    "environment" = var.environment
  })
}

resource "aws_route_table_association" "private_subnet_1_assoc" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_2_assoc" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_3_assoc" {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "sg" {
  name        = "${var.customer_name}-${var.environment}-default-sg"
  description = "Default SG to allow traffic from the VPC"
  vpc_id      = aws_vpc.main.id
  depends_on  = [aws_vpc.main]

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  tags = {
    environment = var.environment
  }
}