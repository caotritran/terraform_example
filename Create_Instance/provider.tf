terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.87.0"
    }
  }
}

provider "google" {
  credentials = file("credential.json")
  project     = var.projectid
  region      = var.region
  zone        = join("-", [var.region, "1"])
}