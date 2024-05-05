terraform {
  required_providers {
    auth0 = {
      source = "auth0/auth0"
      version = "1.2.0"
    }
  }
}

provider "auth0" {
  # Configuration options
}