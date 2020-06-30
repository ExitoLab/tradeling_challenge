# Deploy a Production Ready Kubernetes Cluster

The kubernetes cluster was created at first with kops but i discovered that kops dont have strong support for terraform 0.12

The kubernetes cluster was setup using kubespray and ansible. Kubespray provisioned the infrastructure (vpc, elb,iam, subnets, kube master, kube nodes). Anisble was used to deploy the kubernetes clusters. 

Centos base image is the operating system for all the servers

I tried to adopt terraform layering in this project. 

# PREREQUISITES

1. Ansible >=2.8, terraform >=0.12
2. Ansible control machine is required preferrable a mac or linux machine. 


# SETUP THE CLUSTER

The following resources in AWS will be provisioned as part of the cluster creation process.

1. 2 EC2 instances for the master node
2. 3 EC2 instances for etcd
3. 3 EC2 instances for worker nodes
4. 2 EC2 instances for bastion
5. 1 AWS Elastic Load Balancer
6. 1 VPC with Public and Private Subnet

### Instructions on how to setup the kubernetes cluster. 

#### Usage

```ShellSession

1. Navigate to 03-kubespray. This is the folder to setup kubernetes 

2. # Install dependencies from ``requirements.txt``
sudo pip3 install -r requirements.

3. Create a private and public key using `ssh-keygen`
The public key will be added to 02-key/main.tf. Replace your public key with public_key in 
02-key/main.tf.  This is very important because aws will use this public key for authentication. 


4. # CREATE CREDENTIALS.TFVARS.
Create contrib/terraform/aws/credentials.tfvars with the following contents:

cd 03-kubespray/contrib/terraform/aws/
cp credentials.tfvars.example credentials.tfvars

AWS_ACCESS_KEY_ID = ""
AWS_SECRET_ACCESS_KEY = ""
AWS_SSH_KEY_NAME = "tradeling-key" # This is the key pair name on 02-key/main.tf
AWS_DEFAULT_REGION = "ap-southeast-1

5. Run `cd 03-kubespray/contrib/terraform/aws/` then run ` terraform init `

6. Proceed with deploying the infrastructure using terraform 
Run `terraform apply -var-file=credentials.tfvars`


Once the infrastructure is provisioned, we now proceed with setting up the inventory file for ansible to configure the cluster 

7. Navigate to cd 03-kubespray/inventory. We will need to edit the hosts file
For bastion host, the ansible_host will be in this format assuming ip is 52.210.233.93. This is the Public DNS (IPv4) of the ec2 instance. Pls make sure the Public DNS (IPv4) is used

ansible_host=ec2-52-210-233-93.eu-west-1.compute.amazonaws.com

8. Bastion host should be this 

[bastion]
bastion
bastion

Add calico 

[calico-rr]

Also, add calico to [k8s-cluster:children] ike this 

[k8s-cluster:children]
kube-node
kube-master
calico-rr

9. Run the following commands for passwordless ssh 
eval $(ssh-agent)
ssh-add -D
ssh-add /home/djohn/Desktop/Toks/tradeling-challenge #Path to the private key created


10. Run the ansible command to setup the kubernetes cluster

ansible-playbook -i ./inventory/hosts ./cluster.yml -e ansible_user=centos --become --private-key=/home/djohn/Desktop/Toks/tradeling-challenge -e bootstrap_os=centos -b --become-user=root  -e cloud_provider=aws  --flush-cache -vvv

The private key will be replaced

```