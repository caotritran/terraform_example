# Apply kube manifest to eks cluster
resource "null_resource" "add_kubeconfig" {
  depends_on = [
    aws_eks_cluster.eks-prod,
    aws_eks_node_group.worker-nodes
  ]

  provisioner "local-exec" {
    working_dir = path.module

    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
mkdir -p temp;
cat <<EOF >> temp/kubeconfig
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-prod.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-prod.certificate_authority[0].data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws
      args:
        - eks
        - get-token
        - --cluster-name
        - ${var.cluster-name}
        - --region
        - ${var.aws_region}
      env:
        - name: AWS_DEFAULT_REGION
          value: ${var.aws_region}
        - name: AWS_PROFILE
          value: terraform
EOT
    
  }

  /*triggers = {
    fluentd_rendered    = data.template_file.fluentd.rendered
    autoscaler_rendered = data.template_file.autoscaler.rendered
    aws_cni_rendered    = data.template_file.aws_cni.rendered
    endpoint            = aws_eks_cluster.eks-prod.id
  }*/
}


# Apply kube manifest to eks cluster
resource "null_resource" "install_kube_manifests" {
  provisioner "local-exec" {
    working_dir = path.module

    interpreter = ["/bin/bash", "-c"]

    command = <<EOT
echo '${null_resource.install_kube_manifests.triggers.fluentd_rendered}' > temp/fluentd.yaml
kubectl apply -f temp/ --kubeconfig temp/kubeconfig
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml --kubeconfig temp/kubeconfig
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert-manager.yaml --kubeconfig temp/kubeconfig
EOT

  }
  depends_on = [
    null_resource.add_kubeconfig
  ]

  triggers = {
    fluentd_rendered    = data.template_file.fluentd.rendered
    #autoscaler_rendered = data.template_file.autoscaler.rendered
    #aws_cni_rendered    = data.template_file.aws_cni.rendered
    endpoint            = aws_eks_cluster.eks-prod.id
  }
}