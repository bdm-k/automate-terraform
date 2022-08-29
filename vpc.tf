data "aws_vpc" "main" {
  id = "vpc-0be0f2ce9a53c9fbc"
}

data "aws_subnet" "main" {
  id = "subnet-089c3a6855c69537b"
}

resource "aws_vpc" "test" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "test"
  }
}

resource "aws_subnet" "test-1a" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "172.16.0.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "test-1a"
  }
}

resource "aws_subnet" "test-1c" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "test-1c"
  }
}

resource "aws_subnet" "test-1d" {
  vpc_id     = aws_vpc.test.id
  cidr_block = "172.16.2.0/24"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "test-1d"
  }
}

resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "test"
  }
}

resource "aws_route_table" "test" {
  vpc_id = aws_vpc.test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id
  }

  tags = {
    Name  = "test"
  }
}

resource "aws_route_table" "test-private" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name  = "test-private"
  }
}

resource "aws_main_route_table_association" "test" {
  vpc_id         = aws_vpc.test.id
  route_table_id = aws_route_table.test.id
}

resource "aws_route_table_association" "test-1a" {
  subnet_id      = aws_subnet.test-1a.id
  route_table_id = aws_route_table.test.id
}

resource "aws_route_table_association" "test-1c" {
  subnet_id      = aws_subnet.test-1c.id
  route_table_id = aws_route_table.test-private.id
}

resource "aws_route_table_association" "test-1d" {
  subnet_id      = aws_subnet.test-1d.id
  route_table_id = aws_route_table.test-private.id
}
