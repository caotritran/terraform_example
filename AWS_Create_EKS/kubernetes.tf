provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks-prod.endpoint
  token                  = data.aws_eks_cluster_auth.eks-prod.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-prod.certificate_authority.0.data)
}
