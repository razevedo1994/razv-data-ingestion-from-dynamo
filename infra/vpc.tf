resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    name            = "${var.project_prefix}-vpc"
    env             = var.env
    project_name    = var.project_prefix
  }
}

resource "aws_subnet" "this" {
    vpc_id              = aws_vpc.this.id
    cidr_block          = "10.0.1.0/24"
    availability_zone   = "us-east-1a"

    tags = {
      name          = "${var.project_prefix}-subnet"
      env           = var.env
      project_name  = var.project_prefix
    }
}

resource "aws_security_group" "this" {
    name    = "${var.project_prefix}-security-group"

    vpc_id  = aws_vpc.this.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Allow inbound HTTP traffic from anywhere
  }

  # Define outbound rules (allowing traffic)
  egress {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Allow outbound traffic to anywhere
  }

  tags = {
    env             = var.env
    project_name    = var.project_prefix
  }
}

