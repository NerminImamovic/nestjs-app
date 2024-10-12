provider "aws" {
  region = "us-east-1"
}


# module "ecr_backend" {
#   source = "./modules/ecr"

#   repo_name = "nestjs-app"
# }

module "iam" {
  source = "./modules/iam"
}

module "vpc" {
  source = "./modules/vpc"
}

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.subnet_ids
}

module "ecs" {
  source = "./modules/ecs"
  cluster_name = "nestjs-cluster"
  execution_role_arn = module.iam.execution_role_arn
  subnets = module.vpc.subnet_ids
  security_group_id = module.vpc.ecs_sg_id
  lb_target_group_arn = module.load_balancer.target_group_arn
}
