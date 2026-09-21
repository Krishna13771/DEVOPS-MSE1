# ---------------------------------------------------
# Current AWS Account
# ---------------------------------------------------

data "aws_caller_identity" "current" {}

# ---------------------------------------------------
# Default VPC
# ---------------------------------------------------

data "aws_vpc" "default" {
  default = true
}

# ---------------------------------------------------
# Available Availability Zones
# ---------------------------------------------------

data "aws_availability_zones" "available" {
  state = "available"
}

# ---------------------------------------------------
# Latest Amazon Linux 2023 AMI
# ---------------------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---------------------------------------------------
# Default Subnets
# ---------------------------------------------------

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ---------------------------------------------------
# EC2 Instances
# ---------------------------------------------------

resource "aws_instance" "app" {
  count = var.instance_count

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = data.aws_subnets.default.ids[
    count.index % length(data.aws_subnets.default.ids)
  ]

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  tags = {
    Name        = "${var.project_name}-${var.environment}-${count.index + 1}"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}