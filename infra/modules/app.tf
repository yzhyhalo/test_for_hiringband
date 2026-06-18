
resource "helm_release" "app" {
  name  = "app"
  chart = "../../../../../../helm/app"
  #chart = "${path.root}/../../helm/app"
  cleanup_on_fail  = true
  namespace        = "app"
  create_namespace = true


  depends_on = [module.eks.cluster_id]
}
