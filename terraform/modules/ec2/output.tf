output "instanceid" {
  value = module.ec2_instance.id
}

output "aws_ami_id" {
    value = data.aws_ami.latest-amazon-image.id
}
