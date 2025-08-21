resource "aws_instance" "webserver" {



  for_each = var.instances
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = each.value
  key_name                   = var.key_name
  subnet_id                   = var.subnet_id
  security_groups             = var.security_group_ids
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.security_group_ids
  user_data                   = var.user_data
  tags = merge(
    { Name = "${var.name}-${each.key}" },
    var.tags
  )
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


####..