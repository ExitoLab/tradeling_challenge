#Global Vars
aws_cluster_name = "tradeling"

#VPC Vars
aws_vpc_cidr_block       = "10.0.0.0/16"
aws_cidr_subnets_private = ["10.0.5.0/24", "10.0.6.0/24"]
aws_cidr_subnets_public  = ["10.0.80.0/24", "10.0.81.0/24"]

#Bastion Host
aws_bastion_size = "t2.medium"

#Kubernetes Cluster
aws_kube_master_num  = 3
aws_kube_master_size = "t2.medium"

aws_etcd_num  = 3
aws_etcd_size = "t2.medium"

aws_kube_worker_num  = 6
aws_kube_worker_size = "t2.medium"

#Settings AWS ELB
aws_elb_api_port                = 6443
k8s_secure_api_port             = 6443
kube_insecure_apiserver_address = "0.0.0.0"

default_tags = {
  "env"       = "devtest"
  "Product"   = "kubernetes"
  "terraform" = true
}

inventory_file = "../../../inventory/hosts"
