output "getvpcid" {
  value = module.template-vpc.vpc_id
}


output "subnets" { 
  value = module.template-vpc.public_subnets
}