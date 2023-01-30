module "alb-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.alb-name
  description = "Allows ports 22,80,443 "
  vpc_id      = var.vpc_id

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["https-443-tcp","http-80-tcp","ssh-tcp"]

}

