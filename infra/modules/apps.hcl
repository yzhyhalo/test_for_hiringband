resource "helm_release" "argocd" {
  name = "argocd"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "7.7.0"
  timeout          = 600

  values = [file("argocd.yaml")]

}

resource "helm_release" "metric-server" {
  name = "metric-server"

  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  chart            = "metrics-server"
  namespace        = "metrics"
  create_namespace = true
  version          = "0.8"
  timeout          = 600

  values = [file("metrics.yaml")]
}
