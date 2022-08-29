resource "aws_instance" "main-public" {
  ami                    = "ami-07200fa04af91f087"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.test-1a.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "EC2 on 1a"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH connection"
  vpc_id      = aws_vpc.test.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_eip" "main-public" {
  instance = aws_instance.main-public.id
  vpc      = true
}
