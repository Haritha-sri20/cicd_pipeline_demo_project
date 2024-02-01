
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.14.0"
    }
  }
}

terraform {
  backend "gcs" {
    bucket = "haritha-pipeline-bucket" # GCS bucket name to store terraform tfstate
    prefix = "cicd-demo/dev/ArtifactRegistry"               # Prefix name should be unique for each Terraform project having same remote state bucket.
  }
}
provider "google" {
  project = "haritha-project1"
}
resource "google_artifact_registry_repository" "my-repo" {
  location      = var.location
  repository_id = var.repository_id
  description   = "For docker repository"
  format        = var.format

  docker_config {
    immutable_tags = false
  }
}
