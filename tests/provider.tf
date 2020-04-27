provider "aws" {
  version                 = "2.55.0"
  profile                 = "cmdlabtf-master"
  skip_metadata_api_check = true
}

data "aws_eks_cluster" "cluster" {
  name = module.cluster.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.cluster.cluster_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "1.11.1"
}
