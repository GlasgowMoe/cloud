module "template-vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name = var.region
  cidr = "10.0.0.0/16"
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  #enable_nat_gateway = true
  tags = {
    Terraform = "true"
    Environment = "${var.environment[0]}"
  }
}


output "getsubnetid" {
  value = module.template-vpc.private_subnets
}