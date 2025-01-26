terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = "./my_keys/de-zoom-camp-449005-ca1ca67c517c.json"
  project     = "de-zoom-camp-449005"
  region      = "us-central1"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "de-zoom-camp-449005-terra-bucket"
  location      = "US"
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}