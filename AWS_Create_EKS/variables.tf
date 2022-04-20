# Provider
variable "aws_region" {
  type        = string
  description = "Region AWS"
}
variable "profile" {
  type        = string
  description = "profile config in aws cli"
}
variable "cluster-name" {
  type        = string
  description = "eks cluster name"
}

# VPC
variable "vpc_id" {
  type        = string
  description = "VPC id AWS"
}
variable "subnet_ids" {
  type        = list(string)
  description = "list subnets id of VPC"
}

#variable "public_subnet_ids" {
#  type        = list(string)
#  description = "list public subnets id of VPC"
#}

variable "ec2_ssh_key" {
  type        = string
  description = "SSH key pair"
}

variable "disk_size" {
  type        = string
  description = "disk size for EC2 of nodegroup"
}

variable "capacity_type" {
  type        = string
  description = "Type of capacity associated with the EKS Node Group. Valid values: ON_DEMAND, SPOT"
}

/*variable "endpoint_private_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
}

variable "endpoint_public_access" {
  type        = bool
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled."

}

variable "public_access_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks which can access the Amazon EKS private API server endpoint, when public access is disabled"
}*/

#variable "source_security_group_ids" {
#  type        = list(string)
#  description = " Set of EC2 Security Group IDs to allow SSH access (port 22) from on the worker nodes"
#}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
}

variable "instance_types" {
  type        = list(string)
  description = "instance types EC2"
}