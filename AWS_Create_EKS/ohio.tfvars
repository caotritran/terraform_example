# Provider config
aws_region   = "us-east-2"
profile      = "terraform"
cluster-name = "eks-test"

# VPC
vpc_id     = "vpc-xxxxx"
subnet_ids = ["subnet-xxxx", "subnet-yyyy", "subnet-zzzz""]

# EKS
ec2_ssh_key             = "keypair"
disk_size               = 30
capacity_type           = "ON_DEMAND"
#endpoint_private_access = true
#endpoint_public_access  = true
#public_access_cidrs     = ["1.2.3.4/32"]
cluster_version = "1.22"
instance_types  =   ["t3.medium"]
