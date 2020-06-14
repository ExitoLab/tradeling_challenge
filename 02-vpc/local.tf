locals {
  azs         = ["${var.region}a", "${var.region}b", "${var.region}c"]
  environment = "dev"

  kops_state_bucket_name = "${local.environment}-kops-state"
  // Needs to be a FQDN
  kubernetes_cluster_name = "k8s-dev0.domain.com"
  ingress_ips             = ["10.0.80.0/24", "10.0.81.0/24"]

  tags = {
    environment = "${local.environment}"
    terraform   = true
  }
}
