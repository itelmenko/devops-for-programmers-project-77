terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    datadog = {
      source  = "DataDog/datadog"
      version = "~> 3.20.0"
    }
  }
}

variable "do_token" {
  type = string
}

provider "digitalocean" {
  token = var.do_token
}

variable "datadog_api_key" {
  type = string
}

variable "datadog_app_key" {
  type = string
}

# https://docs.datadoghq.com/account_management/api-app-keys/
provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  api_url = "https://api.datadoghq.eu/"
}