resource "aws_security_group" "private-db" {
  name   = "private-db"
  vpc_id = aws_vpc.test.id

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    # cidr_blocks = [aws_subnet.test-1a.cidr_block]
    security_groups = [aws_security_group.allow_ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-db"
  }
}

resource "aws_db_subnet_group" "test" {
  description = "Contains subnet 'test-1d'"
  subnet_ids  = [aws_subnet.test-1d.id, aws_subnet.test-1c.id]
}

resource "aws_db_instance" "test" {
  allocated_storage      = 20
  max_allocated_storage  = 200
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "13.7"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = "yeconnect"
  vpc_security_group_ids = [aws_security_group.private-db.id]
  db_subnet_group_name   = aws_db_subnet_group.test.name
  skip_final_snapshot    = true
}
