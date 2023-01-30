terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
    random = {
      source  = "hashicorp/random"
    }
  }

  cloud {
    organization =  "Tutorial-moekandi"

    workspaces {
      name = "Terraform-lab"
    }
  }
}

  provider "aws" {
  region = "us-east-2"
}
module "myvpc" {
  source = "./modules/networking"
  azs = var.azs
  environment =  var.environment
  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  region = var.region
}



module "sg1" {
  source = "./modules/sg"
  alb-name = "test-sg"
  vpc_id = module.myvpc.getvpcid
}



module "mylb" {
  source = "./modules/lb"
  vpc_id = module.myvpc.getvpcid
  environment = var.environment
  instance = [module.instance1.instanceid]
  target_instance = module.instance1.instanceid
  sg = module.sg1.getsgid
  getsubnetsid = module.myvpc.subnets
}

module "instance1" {
  source = "./modules/ec2"
  env_prefix = "dev"
  image_name = var.image[0]
  my_public_key_location = var.my_public_key_location
  instance_type = "t2.micro"
  avail_zone = var.azs[0]
  subnet_id = module.myvpc.getsubnetid[0]
  vpc_id =  module.myvpc.getvpcid
  vpc_security_group_ids = module.sg1.getsgid
  my_ip =  "0.0.0.0/0"

}


