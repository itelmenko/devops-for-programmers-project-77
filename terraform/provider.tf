terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.20.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_api_token
}

# https://docs.datadoghq.com/account_management/api-app-keys/
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://${var.datadog_domain}/"
}