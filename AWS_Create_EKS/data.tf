# Logging and Autoscaling components
data "template_file" "fluentd" {
  template = file("${path.module}/templates/fluentd.yaml.tpl")

  vars = {
    cluster_name         = var.cluster-name
    region             = var.aws_region
    cw_retention_in_days = aws_cloudwatch_log_group.eks-prod.retention_in_days
  }
}

# Deploy Autoscaler
data "template_file" "autoscaler" {
  template = file("${path.module}/templates/autoscaler.yaml.tpl")

  vars = {
    cluster_name         = var.cluster-name
    region               = var.aws_region
    cw_retention_in_days = aws_cloudwatch_log_group.eks-prod.retention_in_days
  }
}

# Deploy AWS-CNI
data "template_file" "aws_cni" {
  template = file("${path.module}/templates/aws-k8s-cni.yaml.tpl")

  vars = {
    region = var.aws_region
  }
}