# Deploy a Production Ready Kubernetes Cluster

The kubernetes cluster was created at first with kops but i discovered that kops dont have strong support for terraform 0.12

The kubernetes cluster was setup using kubespray and ansible. Kubespray provisioned the infrastructure (vpc, elb,iam, subnets, kube master, kube nodes). Anisble was used to deploy the kubernetes clusters. 

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

9. Run cp -avr inventory/sample inventory/mycluster




eval $(ssh-agent)
ssh-add -D
ssh-add /home/djohn/Desktop/Toks/tradeling-challenge








# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

Note: When Ansible is already installed via system packages on the control machine, other python packages installed via `sudo pip install -r requirements.txt` will go to a different directory tree (e.g. `/usr/local/lib/python2.7/dist-packages` on Ubuntu) from Ansible's (e.g. `/usr/lib/python2.7/dist-packages/ansible` still on Ubuntu).
As a consequence, `ansible-playbook` command will fail with:

```raw
ERROR! no action detected in task. This often indicates a misspelled module name, or incorrect module path.
```

probably pointing on a task depending on a module present in requirements.txt (i.e. "unseal vault").

One way52-210-233-93. of solving this would be to uninstall the Ansible package and then, to install it via pip but it is not always possible.
A workaround consists of setting `ANSIBLE_LIBRARY` and `ANSIBLE_MODULE_UTILS` environment variables respectively to the `ansible/modules` and `ansible/module_utils` subdirectories of pip packages installation location, which can be found in the Location field of the output of `pip show [package]` before executing `ansible-playbook`.









![Kubernetes Logo](https://raw.githubusercontent.com/kubernetes-sigs/kubespray/master/docs/img/kubernetes-logo.png)

If you have questions, check the documentation at [kubespray.io](https://kubespray.io) and join us on the [kubernetes slack](https://kubernetes.slack.com), channel **\#kubespray**.
You can get your invite [here](http://slack.k8s.io/)

- Can be deployed on **AWS, GCE, Azure, OpenStack, vSphere, Packet (bare metal), Oracle Cloud Infrastructure (Experimental), or Baremetal**
- **Highly available** cluster
- **Composable** (Choice of the network plugin for instance)
- Supports most popular **Linux distributions**
- **Continuous integration tests**

## Quick Start

To deploy the cluster you can use :

### Ansible

#### Usage

```ShellSession
# Install dependencies from ``requirements.txt``
sudo pip3 install -r requirements.txt

# Copy ``inventory/sample`` as ``inventory/mycluster``
cp -rfp inventory/sample inventory/mycluster

# Update Ansible inventory file with inventory builder
declare -a IPS=(10.10.1.3 10.10.1.4 10.10.1.5)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# Review and change parameters under ``inventory/mycluster/group_vars``
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml

# Deploy Kubespray with Ansible Playbook - run the playbook as root
# The option `--become` is required, as for example writing SSL keys in /etc/,
# installing packages and interacting with various systemd daemons.
# Without --become the playbook will fail to run!
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml
```

Note: When Ansible is already installed via system packages on the control machine, other python packages installed via `sudo pip install -r requirements.txt` will go to a different directory tree (e.g. `/usr/local/lib/python2.7/dist-packages` on Ubuntu) from Ansible's (e.g. `/usr/lib/python2.7/dist-packages/ansible` still on Ubuntu).
As a consequence, `ansible-playbook` command will fail with:

```raw
ERROR! no action detected in task. This often indicates a misspelled module name, or incorrect module path.
```

probably pointing on a task depending on a module present in requirements.txt (i.e. "unseal vault").

One way52-210-233-93. of solving this would be to uninstall the Ansible package and then, to install it via pip but it is not always possible.
A workaround consists of setting `ANSIBLE_LIBRARY` and `ANSIBLE_MODULE_UTILS` environment variables respectively to the `ansible/modules` and `ansible/module_utils` subdirectories of pip packages installation location, which can be found in the Location field of the output of `pip show [package]` before executing `ansible-playbook`.

### Vagrant

For Vagrant we need to install python dependencies for provisioning tasks.
Check if Python and pip are installed:

```ShellSession
python -V && pip -V
```

If this returns the version of the software, you're good to go. If not, download and install Python from here <https://www.python.org/downloads/source/>
Install the necessary requirements

```ShellSession
sudo pip install -r requirements.txt
vagrant up
```

## Documents

- [Requirements](#requirements)
- [Kubespray vs ...](docs/comparisons.md)
- [Getting started](docs/getting-started.md)
- [Ansible inventory and tags](docs/ansible.md)
- [Integration with existing ansible repo](docs/integration.md)
- [Deployment data variables](docs/vars.md)
- [DNS stack](docs/dns-stack.md)
- [HA mode](docs/ha-mode.md)
- [Network plugins](#network-plugins)
- [Vagrant install](docs/vagrant.md)
- [CoreOS bootstrap](docs/coreos.md)
- [Fedora CoreOS bootstrap](docs/fcos.md)
- [Debian Jessie setup](docs/debian.md)
- [openSUSE setup](docs/opensuse.md)
- [Downloaded artifacts](docs/downloads.md)
- [Cloud providers](docs/cloud.md)
- [OpenStack](docs/openstack.md)
- [AWS](docs/aws.md)
- [Azure](docs/azure.md)
- [vSphere](docs/vsphere.md)
- [Packet Host](docs/packet.md)
- [Large deployments](docs/large-deployments.md)
- [Adding/replacing a node](docs/nodes.md)
- [Upgrades basics](docs/upgrades.md)
- [Air-Gap installation](docs/offline-environment.md)
- [Roadmap](docs/roadmap.md)

## Supported Linux Distributions

- **Container Linux by CoreOS**
- **Debian** Buster, Jessie, Stretch, Wheezy
- **Ubuntu** 16.04, 18.04, 20.04
- **CentOS/RHEL** 7, 8 (experimental: see [centos 8 notes](docs/centos8.md))
- **Fedora** 30, 31
- **Fedora CoreOS** (experimental: see [fcos Note](docs/fcos.md))
- **openSUSE** Leap 42.3/Tumbleweed
- **Oracle Linux** 7, 8 (experimental: [centos 8 notes](docs/centos8.md) apply)

Note: Upstart/SysV init based OS types are not supported.

## Supported Components

- Core
  - [kubernetes](https://github.com/kubernetes/kubernetes) v1.18.3
  - [etcd](https://github.com/coreos/etcd) v3.3.12
  - [docker](https://www.docker.com/) v19.03 (see note)
  - [containerd](https://containerd.io/) v1.2.13
  - [cri-o](http://cri-o.io/) v1.17 (experimental: see [CRI-O Note](docs/cri-o.md). Only on fedora, ubuntu and centos based OS)
- Network Plugin
  - [cni-plugins](https://github.com/containernetworking/plugins) v0.8.6
  - [calico](https://github.com/projectcalico/calico) v3.14.1
  - [canal](https://github.com/projectcalico/canal) (given calico/flannel versions)
  - [cilium](https://github.com/cilium/cilium) v1.7.4
  - [contiv](https://github.com/contiv/install) v1.2.1
  - [flanneld](https://github.com/coreos/flannel) v0.12.0
  - [kube-ovn](https://github.com/alauda/kube-ovn) v1.2.0
  - [kube-router](https://github.com/cloudnativelabs/kube-router) v0.4.0
  - [multus](https://github.com/intel/multus-cni) v3.4.2
  - [weave](https://github.com/weaveworks/weave) v2.6.4
- Application
  - [cephfs-provisioner](https://github.com/kubernetes-incubator/external-storage) v2.1.0-k8s1.11
  - [rbd-provisioner](https://github.com/kubernetes-incubator/external-storage) v2.1.1-k8s1.11
  - [cert-manager](https://github.com/jetstack/cert-manager) v0.11.1
  - [coredns](https://github.com/coredns/coredns) v1.6.7
  - [ingress-nginx](https://github.com/kubernetes/ingress-nginx) v0.32.0

Note: The list of validated [docker versions](https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker) is 1.13.1, 17.03, 17.06, 17.09, 18.06, 18.09 and 19.03. The recommended docker version is 19.03. The kubelet might break on docker's non-standard version numbering (it no longer uses semantic versioning). To ensure auto-updates don't break your cluster look into e.g. yum versionlock plugin or apt pin).

## Requirements

- **Minimum required version of Kubernetes is v1.16**
- **Ansible v2.9+, Jinja 2.11+ and python-netaddr is installed on the machine that will run Ansible commands**
- The target servers must have **access to the Internet** in order to pull docker images. Otherwise, additional configuration is required (See [Offline Environment](docs/offline-environment.md))
- The target servers are configured to allow **IPv4 forwarding**.
- **Your ssh key must be copied** to all the servers part of your inventory.
- The **firewalls are not managed**, you'll need to implement your own rules the way you used to.
    in order to avoid any issue during deployment you should disable your firewall.
- If kubespray is ran from non-root user account, correct privilege escalation method
    should be configured in the target servers. Then the `ansible_become` flag
    or command parameters `--become or -b` should be specified.

Hardware:
These limits are safe guarded by Kubespray. Actual requirements for your workload can differ. For a sizing guide go to the [Building Large Clusters](https://kubernetes.io/docs/setup/cluster-large/#size-of-master-and-master-components) guide.

- Master
  - Memory: 1500 MB
- Node
  - Memory: 1024 MB

## Network Plugins

You can choose between 10 network plugins. (default: `calico`, except Vagrant uses `flannel`)

- [flannel](docs/flannel.md): gre/vxlan (layer 2) networking.

- [Calico](https://docs.projectcalico.org/latest/introduction/) is a networking and network policy provider. Calico supports a flexible set of networking options
    designed to give you the most efficient networking across a range of situations, including non-overlay
    and overlay networks, with or without BGP. Calico uses the same engine to enforce network policy for hosts,
    pods, and (if using Istio and Envoy) applications at the service mesh layer.

- [canal](https://github.com/projectcalico/canal): a composition of calico and flannel plugins.

- [cilium](http://docs.cilium.io/en/latest/): layer 3/4 networking (as well as layer 7 to protect and secure application protocols), supports dynamic insertion of BPF bytecode into the Linux kernel to implement security services, networking and visibility logic.

- [contiv](docs/contiv.md): supports vlan, vxlan, bgp and Cisco SDN networking. This plugin is able to
    apply firewall policies, segregate containers in multiple network and bridging pods onto physical networks.

- [weave](docs/weave.md): Weave is a lightweight container overlay network that doesn't require an external K/V database cluster.
    (Please refer to `weave` [troubleshooting documentation](https://www.weave.works/docs/net/latest/troubleshooting/)).

- [kube-ovn](docs/kube-ovn.md): Kube-OVN integrates the OVN-based Network Virtualization with Kubernetes. It offers an advanced Container Network Fabric for Enterprises.

- [kube-router](docs/kube-router.md): Kube-router is a L3 CNI for Kubernetes networking aiming to provide operational
    simplicity and high performance: it uses IPVS to provide Kube Services Proxy (if setup to replace kube-proxy),
    iptables for network policies, and BGP for ods L3 networking (with optionally BGP peering with out-of-cluster BGP peers).
    It can also optionally advertise routes to Kubernetes cluster Pods CIDRs, ClusterIPs, ExternalIPs and LoadBalancerIPs.

- [macvlan](docs/macvlan.md): Macvlan is a Linux network driver. Pods have their own unique Mac and Ip address, connected directly the physical (layer 2) network.

- [multus](docs/multus.md): Multus is a meta CNI plugin that provides multiple network interface support to pods. For each interface Multus delegates CNI calls to secondary CNI plugins such as Calico, macvlan, etc.

The choice is defined with the variable `kube_network_plugin`. There is also an
option to leverage built-in cloud provider networking instead.
See also [Network checker](docs/netcheck.md).

## Community docs and resources

- [kubernetes.io/docs/setup/production-environment/tools/kubespray/](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)
- [kubespray, monitoring and logging](https://github.com/gregbkr/kubernetes-kargo-logging-monitoring) by @gregbkr
- [Deploy Kubernetes w/ Ansible & Terraform](https://rsmitty.github.io/Terraform-Ansible-Kubernetes/) by @rsmitty
- [Deploy a Kubernetes Cluster with Kubespray (video)](https://www.youtube.com/watch?v=CJ5G4GpqDy0)

## Tools and projects on top of Kubespray

- [Digital Rebar Provision](https://github.com/digitalrebar/provision/blob/v4/doc/integrations/ansible.rst)
- [Terraform Contrib](https://github.com/kubernetes-sigs/kubespray/tree/master/contrib/terraform)

## CI Tests

[![Build graphs](https://gitlab.com/kargo-ci/kubernetes-sigs-kubespray/badges/master/build.svg)](https://gitlab.com/kargo-ci/kubernetes-sigs-kubespray/pipelines)

CI/end-to-end tests sponsored by Google (GCE)
See the [test matrix](docs/test_cases.md) for details.
