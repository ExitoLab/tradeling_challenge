# Tradeling DevOps Challenge

![Tradeling Logo]("https://c8n.tradeling.com/assets/svgs/tradeling-logo.svg)

The challenge is very interesting, i was able to learn new thing in the process. I had an issue which took most of my time. EBS CSI Driver was not properly configured using kubespray and that should be a bug from kubespray. MongoDB and traefik was not configured until i solve the issue. 

The volumes on AWS was not mounted and alot of things were not working until i finally resolved the issue. Storageclass was not recognized.

I followed the link below in creating the EBS CSI Driver manuallly https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html 


The following things were achieved during the exercrise 

1. Created kubernetes cluster using ansible, terraform and kubespray automation tool on aws 
2. Build and push the nodejs image on dockerhub using Github Actions 
3. Setup mongoDB replicaset on Kubernetes, configured pvc, storageclass, pv properly using helm
4. Setup Traefik load balancer using helm 
5. Setup Montoring on kubernetes using grafana, prometheus, alert manager using helm 
6. Ensure there is an s3 buckets to keep all terraform state files 
7. Screenshot can be found in https://github.com/ExitoLab/tradeling_challenge/tree/master/tradeling_challenge_screenshots
8. Link to readme file on k8 cluster https://github.com/ExitoLab/tradeling_challenge/tree/master/03-kubespray
9. Link to readme file on nodejs app  https://github.com/ExitoLab/tradeling_challenge/tree/master/app

I was unable to automate some of the helm deployment but i kept the scripts in the 06-scripts folder. Due to time constraint, i ran the helm deployments manually they were all successful. 

Presently, the bastion host do not have kubectl and helm. The kubernetes nodes are not accesible over the internet. To access the cluster, we have to go through the bastion host. 

We can also use the bastion host as a proxy to ssh into any of the kube-master node. To ssh into the kubernetes master nodes run ` cd 03-kubespray && ssh -F ssh-bastion.conf centos@<kube-master-ipaddress> `

Below is the process of configuring kubectl manually on the bastion host 

After identifying the IP address, we can SSH to the first master. Get master ip from 
` cat inventory/hosts `

1. Run ` ssh  -F ssh-bastion.conf centos@<first master ip address>  `
2. Run

```ShellSession
sudo su - 
cd ~
cd .kube
cat config
Highlight and copy the kubectl config

ssh int the bastion host (jump server)
Run 
sudo su - 
cd ~
mkdir -p .kube
cd .kube
touch config
vim config and paste the kubectl config file 

After doing this, we will be able to run kubectl commands from our jump server

```

However, if time permits me in the future i will automate all the manually process and see that everything works from 