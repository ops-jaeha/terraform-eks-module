module "network" {
  source = "./modules/vpc"

  project  = var.project
  vpc_cidr = var.vpc_cidr
}