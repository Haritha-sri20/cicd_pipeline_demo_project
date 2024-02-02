
terraform {
  required_version = ">= 1.7.1, < 1.8.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.69.1"
    }
  }
}
terraform {
  backend "gcs" {
    bucket = "haritha-pipeline-bucket"          # GCS bucket name to store terraform tfstate
    prefix = "cicd-demo/dev/ArtifactRegistry"   # Prefix name should be unique for each Terraform project having same remote state bucket.
  }
}
provider "google" {
  project = "haritha-project1"
}
resource "google_cloud_run_v2_service" "default" {
  name     = var.name
  location = var.location
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "asia-south1-docker.pkg.dev/haritha-project1/haritha-cicd-demo-dev-repo/pythondemoimage:latest"
      resources {
        limits = {
          cpu    = "4"
          memory = "2048Mi"
        }
      }
    }
  }
}