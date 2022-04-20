terraform {
  backend "s3" {
    region  = "ap-southeast-1"
    profile = "terraform"
    key     = "EKSstatefile"
    bucket  = "terraformstate-eks-r1"
  }
}