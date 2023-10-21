output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

#These outputs are from the iam-role.tf file.
output "node_role" {
  value = module.iam.node_role
}

output "demo_role" {
  value = module.iam.demo_role
}
