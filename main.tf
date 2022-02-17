module "vpc" {
  source   = "./module/networking"
  vpc_cidr = "168.30.0.0/16"
  
}
module "elb" {
  source  = "./module/elb-classic"
  subnets = module.vpc.pub_sub_ids
  vpc_id  = module.vpc.vpc_id
}


module "ec2" {
  source = "./module/ec2"
  subnet = module.vpc.pub_sub_ids
  vpc_id = module.vpc.vpc_id
}

module "iam" {
  source = "./module/iam"
}

module "route53" {
  source = "./module/route53"
}