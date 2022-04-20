# Provider config
aws_region   = "ap-southeast-1"
profile      = "terraform"
cluster-name = "eks-test2"

# VPC
vpc_id     = "vpc-xxxx"
subnet_ids = ["subnet-xxxx", "subnet-yyyy", "subnet-zzzz"]

# EKS
ec2_ssh_key             = "keypair"
disk_size               = 30
capacity_type           = "ON_DEMAND"
#endpoint_private_access = true
#endpoint_public_access  = true
#public_access_cidrs     = ["115.77.191.44/32"]
cluster_version = "1.22"
#source_security_group_ids = ["sg-0e99e4d59cbcd66a5"]
instance_types  =   ["t3.large"]
