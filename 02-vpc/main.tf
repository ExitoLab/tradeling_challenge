// module "challenge_vpc" {
//   source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v2.39.0"

//   name               = var.vpc_name
//   cidr               = "10.0.0.0/16"
//   azs                = local.azs
//   private_subnets    = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
//   public_subnets     = ["10.0.80.0/24", "10.0.81.0/24", "10.0.82.0/24"]
//   enable_nat_gateway = true

//   tags = {
//     // This is so kops knows that the VPC resources can be used for k8s
//     "kubernetes.io/cluster/${local.kubernetes_cluster_name}" = "shared"
//     "terraform"                                              = true
//     "environment"                                            = "${local.environment}"
//   }

//   // Tags required by k8s to launch services on the right subnets
//   private_subnet_tags = {
//     "kubernetes.io/role/internal-elb" = true
//   }

//   public_subnet_tags = {
//     "kubernetes.io/role/elb" = true
//   }
// }


// resource "aws_security_group" "k8s-common-http-challenge" {
//   name   = "dev_k8s_common_http"
//   vpc_id = module.challenge_vpc.vpc_id
//   tags   = local.tags

//   ingress {
//     from_port   = 80
//     protocol    = "tcp"
//     to_port     = 80
//     cidr_blocks = local.ingress_ips
//   }

//   ingress {
//     from_port   = 443
//     protocol    = "tcp"
//     to_port     = 443
//     cidr_blocks = local.ingress_ips
//   }
// }

// resource "aws_route53_zone" "main-k8-domain" {
//   name = "compactslabs.com.ng"

//   tags = {
//     Environment = "dev"
//     terraform   = true
//   }
// }

// resource "aws_route53_record" "k8-domain-ns" {
//   zone_id = aws_route53_zone.main-k8-domain.zone_id
//   name    = "k8.compactslabs.com.ng"
//   type    = "NS"
//   ttl     = "30"

//   records = [
//     "${aws_route53_zone.main-k8-domain.name_servers.0}",
//     "${aws_route53_zone.main-k8-domain.name_servers.1}",
//     "${aws_route53_zone.main-k8-domain.name_servers.2}",
//     "${aws_route53_zone.main-k8-domain.name_servers.3}",
//   ]
// }


#create key pair on aws
resource "aws_key_pair" "deployer" {
  key_name   = "tradeling-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDp9LF97+TyzHcCOoV9t4FfByZCoZsIM1rB1eNRTWSojoNn2I2ha1l5K4q7+iK5+2hDRlJt2EtBbz0JV4TtmGX7F24lm6bP85FYrCXl2ZLTrPUkjeXj9Bchl8wZ5FSKClycS9rWW4q4LfeGtW1MW19gHBToEvNry6lrxzfdMDY3I+Ul3uo1dDSYYlXF7Zm6DZV447cjFUvvZIL8ETOioFVHWmfv8q30PrcV3oh9DyaA1l/ssfXKMbURqMj0cY1MgXxiBPv6zPOYl2vfEgsy/0yBmuXd82F/FCLDHj64uuPCcolNdsXdMsoHA46wIB/envOCOZzzJLGwM+oH+pdHd/uPQexeTwJ9Lptlyq4tVCzXruu7A6/bxa8pyPKuwXH/1xGoaa5L4JEaXQkVkqN8oxRzyEXWuYpVHhKMAeYS2bHV9kTsg0hOutdkdcDZsMAlKPe5JkYuMugni8oRp1SpVRNGw2CMm+XvLmhh6q4MMen5MHGbyxiGs4ifmEiCMDHWys= djohn@djohn"
}