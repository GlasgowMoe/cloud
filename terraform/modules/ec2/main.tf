module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Terrafrom-instance"

  ami                    = data.aws_ami.latest-amazon-image.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ssh-key.key_name
  monitoring             = false
  vpc_security_group_ids = [var.vpc_security_group_ids]
  subnet_id              = var.subnet_id
  

 
}

resource "aws_key_pair" "ssh-key" {
    key_name = "server_key"
    public_key = file(var.my_public_key_location)
  
}

data "aws_ami" "latest-amazon-image" {
    most_recent = true 
    owners = ["amazon"]
    filter {
        name = "name"
        values = [var.image_name]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]

    }
}



