output "region" {
  value = var.region
}

output "vpc_id" {
  value = "${module.challenge_vpc.vpc_id}"
}

output "vpc_name" {
  value = var.vpc_name
}

output "vpc_cidr_block" {
  value = "${module.challenge_vpc.vpc_cidr_block}"
}

// Public Subnets
output "public_subnet_ids" {
  value = ["${module.challenge_vpc.public_subnets}"]
}

output "public_route_table_ids" {
  value = ["${module.challenge_vpc.public_route_table_ids}"]
}

// Private Subnets
output "private_subnet_ids" {
  value = ["${module.challenge_vpc.private_subnets}"]
}

output "private_route_table_ids" {
  value = ["${module.challenge_vpc.private_route_table_ids}"]
}

output "default_security_group_id" {
  value = "${module.challenge_vpc.default_security_group_id}"
}

output "nat_gateway_ids" {
  value = "${module.challenge_vpc.natgw_ids}"
}

output "availability_zones" {
  value = local.azs
}

output "common_http_sg_id" {
  value = "${aws_security_group.k8s-common-http-challenge.id}"
}

// // Needed for kops
// output "kops_s3_bucket" {
//   value = "${aws_s3_bucket.bucket-challenge.bucket}"
// }

// output "kubernetes_cluster_name" {
//   value = local.kubernetes_cluster_name
// }